# OpenSSL commands to inspect/create CA, CSRs, CRTs...
# See also:
# https://gist.github.com/Soarez/9688998

openssl.show() {
  for f in "$@"; do
    local type="" head args=(-text -noout)
    case $f in
      *.crt|*.cer|*.CSR|*.CRT) type=x509 ;;
      *.[cC][sS][rR]) type=req ;;
      *.key)          type=rsa ;;
      *.pub)          type=rsa; args+=(-pubin) ;;
      *.p12|*.pfx)    type=pkcs12; args=(-nodes -info) ;;
      *.pem)
        head=$(grep -m1 -- '-----BEGIN' "$f")
        case $head in
          *REQUEST---*)      type=req  ;;
          *CERTIFICATE---*)  type=x509 ;;
          *PRIVATE\ KEY---*) type=rsa  ;;
          *PUBLIC\ KEY---*)  type=rsa  ;  args+=(-pubin) ;;
          *)                echo "Unknown: '$head'" >&2 ;;
        esac
      ;;
      *) echo "Unknown: '$f'" >&2 ;;
    esac
    if [[ -n $type ]]; then
      echo "Inspecting $f:"
      openssl "$type" "${args[@]}" -in "$f"
    else
      echo "Error while inspecting $f!" >&2
    fi
  done | less -XFRS
}

openssl.csr.verify() {
  for f in "$@"; do
   openssl req -text -verify -noout -in "$f"
  done
}

openssl.crt2der() {
  if [[ -z $1 ]]; then
    echo 'Convert PEM certificate to DER certificate'
    echo "Usage: ${FUNCNAME[0]} PEM [PEM...]"
    return 1
  fi
  for f in "$@"; do
   openssl x509 -in "${f}" -inform pem -out "${f%.*}.cer" -outform der
  done
}

openssl.crt2pem() {
  if [[ -z $1 ]]; then
    echo 'Convert CRT (DER) certificate to PEM certificate'
    echo "Usage: ${FUNCNAME[0]} CRT [CRT...]"
    return 1
  fi
  for f in "$@"; do
   openssl x509 -in "${f}" -inform der -out "${f%.*}.pem" -outform pem
  done
}

openssl.genrsa() {
  if [[ -z $2 ]]; then
    echo 'Generate RSA private key of given bit length'
    echo "Usage: ${FUNCNAME[0]} KEYNAME BITLENGTH"
    return 1
  fi
  local key=$1 len=$2
  openssl genrsa -out "$key.pem" "$len"
}

openssl.genrsa.2048() {
  if [[ -z $1 ]]; then
    echo 'Generate RSA private key of 2048 bit length'
    echo "Usage: ${FUNCNAME[0]} KEYNAME"
    return 1
  fi
  local key=$1
  openssl.genrsa "$key" 2048
}

openssl.genrsa.4096() {
  if [[ -z $1 ]]; then
    echo 'Generate RSA private key of 4096 bit length'
    echo "Usage: ${FUNCNAME[0]} KEYNAME"
    return 1
  fi
  local key=$1
  openssl.genrsa "$key" 4096
}

openssl.pubkey() {
  if [[ -z $1 ]]; then
    echo 'Generate public key from private key'
    echo "Usage: ${FUNCNAME[0]} PRIVKEY"
    return 1
  fi
  local key=$1
  openssl rsa -in "$key" -pubout -out "${key%.*}.pub"
}

openssl.changepass() {
  if [[ -z $1 ]]; then
    echo 'Change password for private key'
    echo "Usage: ${FUNCNAME[0]} PRIVKEY"
    return 1
  fi
  for f in "$@"; do
    echo "Changing pass for $f:"
    openssl rsa -aes256 -in "$f" -out "$f.new" && \
      mv "$f" "$f.bak" && mv "$f.new" "$f"
  done
}

openssl.issuer() {
  openssl x509 -text -noout -inform der -in "$f" | awk -FURI: '/Issuer.*URI:http/{print $2}' | head -1
}

openssl.cer.getchain() {
  if [[ -z $1 ]]; then
    echo 'Get chain and save certificate PEM + chain PEM'
    echo "Usage: ${FUNCNAME[0]} CER"
    return 1
  fi
  local uri
  for f in "$@"; do
    uri=$(openssl.issuer "$f") && \
    wget -O- -q "$uri" | openssl x509 -inform der -outform pem -out "${f%.cer}-sub.pem" && \
    uri=$(openssl.issuer "${f%.cer}-sub.pem") && \
    wget -O- -q "$uri" | openssl x509 -inform der -outform pem -out "${f%.cer}-root.pem" && \
    cat "${f%.cer}-root.pem" "${f%.cer}-sub.pem" > "${f%.cer}-chain.pem" && \
    openssl x509 -inform der -in "$f" -outform pem -out "${f%.cer}.pem" && \
    rm "${f%.cer}-root.pem" "${f%.cer}-sub.pem" && \
    mv "$f" "$f.bak"
  done
}

openssl.csr() {
  if [[ -z $1 ]]; then
    echo 'Generate certificate signing request from private key'
    echo "Usage: ${FUNCNAME[0]} PRIVKEY"
    return 1
  fi
  local key=$1
  openssl req -out "${key%.*}.csr" -key "$key" -new -sha256
}

openssl.csr.sign() {
  if [[ -z $1 ]]; then
    echo 'Sign a CSR with given private key and issue certificate'
    echo "Usage: ${FUNCNAME[0]} CSR PRIVKEY"
    return 1
  fi
  local csr=$1 key=$2
  openssl x509 -in "$csr" -out "${csr%.*}.cer" -req -signkey $key -days 365 -sha256
}

openssl.p12.extract() {
  local pfx=$1 password
  echo -n "Password: "
  read -s password
  echo
  openssl pkcs12 -in "$pfx" -nokeys -out "${pfx%.*}.crt" -passin "pass:$password"
  openssl pkcs12 -in "$pfx" -nocerts -out "${pfx%.*}.key" -passin "pass:$password" -passout "pass:$password"
}
