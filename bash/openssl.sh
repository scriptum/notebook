# OpenSSL commands to inspect/create CA, CSRs, CRTs...
# See also:
# https://gist.github.com/Soarez/9688998

openssl.show() {
  for f in "$@"; do
    local type="" head
    case $f in
      *.crt|*.cer|*.CSR|*.CRT) type=x509 ;;
      *.[cC][sS][rR]) type=req ;;
      *.pem)
        head=$(grep -m1 -- '-----BEGIN' "$f")
        case $head in
          *REQUEST---*)     type=req ;;
          *CERTIFICATE---*) type=x509 ;;
          *)                echo "Unknown: '$head'" >&2 ;;
        esac
      ;;
      *) echo "Unknown: '$f'" >&2 ;;
    esac
    if [[ -n $type ]]; then
      echo "Inspecting $f:"
      openssl "$type" -text -noout -in "$f"
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
  for f in "$@"; do
   openssl x509 -in "${f}" -out "${f%.*}.der" -outform der
  done
}

openssl.crt2pem() {
  for f in "$@"; do
   openssl x509 -in "${f}" -out "${f%.*}.pem" -outform pem
  done
}

openssl.genrsa() {
  local key=$1 len=$2
  openssl genrsa -out "$key" "$len"
}

openssl.genrsa.2048() {
  local key=$1
  openssl.genkey "$key" 2048
}

openssl.genrsa.4096() {
  local key=$1
  openssl.genkey "$key" 4096
}

openssl.pubkey() {
  local key=$1 pubkey=$2
  openssl rsa -in "$key" -pubout -out "$pubkey"
}

openssl.csr() {
  local key=$1 csr=$2
  openssl req -out "$csr" -key "$key" -new -sha256
}

openssl.csr.sign() {
  openssl x509 -in "$csr" -out "${csr%.*}.cer" -req -signkey $key -days 100
}
