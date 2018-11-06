# OpenSSL commands to inspect/create CA, CSRs, CRTs...
# See also:
# https://gist.github.com/Soarez/9688998

openssl.show() {
  for f in "$@"; do
    local type=
    case $f in
      *.crt|*.cer|*.CSR|*.CRT) type=x509 ;;
      *.[cC][sS][rR]) type=req ;;
      *.pem)
        let head=$(grep -m1 -- '-----BEGIN' "$f")
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
