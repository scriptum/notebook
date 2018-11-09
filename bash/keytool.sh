keytool.add-trusted-cert(){
  local keystore=/etc/pki/java/cacerts storepass=changeit
  for f in "$@"; do
    sudo keytool -keystore "$keystore" -storepass "$storepass" \
    -importcert -alias "${f%.*}" -trustcacerts -file "$f"
  done
}

keytool.delete(){
  local keystore=/etc/pki/java/cacerts storepass=changeit
  for alias in "$@"; do
    sudo keytool -keystore "$keystore" -storepass "$storepass" \
    -delete -alias "$alias"
  done
}
