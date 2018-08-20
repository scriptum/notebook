# Useful functions for Bash

All shell scripts in this directory contain functions. You may include them into your `.bashrc` or use in other scripts. Example:

```sh
source /path/to/notebook/bash/find.sh
```

Include all:

```sh
_NOTEBOOK_PATH=~/git/notebook/bash # replace
_NOTEBOOK_INCLUDE=(
  $_NOTEBOOK_PATH/aliases/*.sh
  $_NOTEBOOK_PATH/*.sh
)
for _INCLUDE in "${_NOTEBOOK_INCLUDE[@]}"; do
  source "$_INCLUDE"
done
unset _NOTEBOOK_PATH _NOTEBOOK_INCLUDE _INCLUDE

```
