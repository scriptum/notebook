postgresql.genpass() {
  local user=$1 pass encpass
  if [[ -z $user ]]; then
    echo 'Usage: postgresql.genpass USERNAME'
    return 1
  fi
  pass=$(tr -cd '0-9a-zA-Z' < /dev/urandom | fold -w16 | head -1)
  echo "$user $pass"
  encpass=$(echo -n "$pass$user" | md5sum | awk '{print "md5"$1}')
  echo "$encpass"
  echo "create user $user with encrypted password '$encpass';"
}
