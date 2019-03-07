keytool.find-keystore(){
  local stores=(
    /etc/pki/java/cacerts
    /Library/Java/JavaVirtualMachines/*/Contents/Home/jre/lib/security/cacerts
    /Library/Java/JavaVirtualMachines/*/Contents/Home/lib/security/cacerts
  )
  for s in "${stores[@]}"; do
    if [[ -f "$s" ]]; then
      echo "$s"
      return
    fi
  done
}

keytool.add-trusted-cert(){
  local keystore=$(keytool.find-keystore) storepass=changeit
  for f in "$@"; do
    sudo keytool -keystore "$keystore" -storepass "$storepass" \
    -importcert -alias "${f%.*}" -trustcacerts -noprompt -file "$f"
  done
}

keytool.delete-cert(){
  local keystore=$(keytool.find-keystore) storepass=changeit
  for alias in "$@"; do
    sudo keytool -keystore "$keystore" -storepass "$storepass" \
    -delete -alias "$alias"
  done
}

keytool.list(){
  local keystore=$(keytool.find-keystore) storepass=changeit
  keytool -keystore "$keystore" -storepass "$storepass" -list | awk '$1!="Certificate"{print $1}'
}
