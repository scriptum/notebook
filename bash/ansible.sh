# create new ansible role
ansible-new-role()
{
  local role_name=$1 f
  [[ -z $role_name ]] && exit -1
  mkdir -p roles/"$role_name"/{defaults,handlers,tasks,templates,files,meta}
  for dir in defaults handlers tasks meta; do
    f="roles/$role_name/$dir/$role_name-$dir.yml"
    case $dir in
      meta)
        echo '---
dependencies: []' > "$f"
        if [[ $2 == service ]]; then
          echo "---
dependencies:
  - role: firewalld
    firewalld_allow:
      - '{{ ${role_name//-/_}_service_port }}/tcp'" > "$f"
        fi
      ;;
      tasks)
        echo '---' > "$f"
        if [[ $2 == service ]]; then
          echo "
- name: Install $role_name
  yum:
    name: '{{ ${role_name//-/_}_service_package }}'
    state: present
  tags: [yum, $role_name]

- name: Configure $role_name
  template:
    src: $role_name.conf.j2
    dest: '{{ ${role_name//-/_}_service_config }}'
  tags: [config, $role_name]

- name: Enable and start $role_name
  service:
    name: '{{ ${role_name//-/_}_service_name }}.service'
    enabled: yes
    state: started
  tags: [service, $role_name]" >> "$f"
        fi
      ;;
      defaults)
        echo '---' > "$f"
        if [[ $2 == service ]]; then
          echo "
${role_name//-/_}_service_name: $role_name
${role_name//-/_}_service_package: $role_name
${role_name//-/_}_service_config: /etc/$role_name.conf
${role_name//-/_}_service_port: " >> "$f"
        fi
      ;;
      handlers)
        echo "---" > "$f"
        if [[ $2 == service ]]; then
          echo "
- name: restart $role_name
  service:
    name: '{{ ${role_name//-/_}_service_name }}.service'
    state: restarted" >> "$f"
        fi
      ;;
      *) echo '---' > "$f";;
    esac
    ln -s "$role_name-$dir.yml" "roles/$role_name/$dir/main.yml"
    xdg-open "roles/$role_name/$dir/$role_name-$dir.yml"
  done
}
