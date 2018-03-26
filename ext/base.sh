## THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

find_dir_path () {
	if [ ! -d $(dirname -- "$1") ]; then
		dirname -- "$1"
		return 1
	fi
	echo $(cd -P -- "$(dirname -- "$1")" && pwd -P)
}

##THIS_BASE_DIR_PATH=$(find_dir_path $0)

is_debug () {
	if [ "$DEBUG_PLAY_PPA" = "true" ]; then
		return 0
	fi

	return 1
}

is_not_debug () {
	! is_debug
}

base_var_init () {

	THE_PLAN_NAME="play-ubuntu-18.04-ppa"


	THE_PLAN_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../.") ## play-ubuntu-18.04-ppa


	THE_BIN_DIR_NAME="bin"
	THE_BIN_DIR_PATH="$THE_PLAN_DIR_PATH/$THE_BIN_DIR_NAME" ## play-ubuntu-18.04-ppa/bin

	THE_EXT_DIR_NAME="ext"
	THE_EXT_DIR_PATH="$THE_PLAN_DIR_PATH/$THE_EXT_DIR_NAME" ## play-ubuntu-18.04-ppa/ext

	THE_VAR_DIR_NAME="var"
	THE_VAR_DIR_PATH="$THE_PLAN_DIR_PATH/$THE_VAR_DIR_NAME" ## play-ubuntu-18.04-ppa/var

	THE_PPA_DIR_NAME="ubuntu"
	THE_PPA_DIR_PATH="$THE_PLAN_DIR_PATH/$THE_PPA_DIR_NAME" ## play-ubuntu-18.04-ppa/ubuntu


	THE_PLAN_DIR_PATH="$THE_PLAN_DIR_PATH"

}

base_var_dump () {

	is_not_debug && return 0


	echo
	echo "### Head: var_dump #############################################################"
	echo "#"
	echo "#"


	echo "THE_PLAN_NAME=$THE_PLAN_NAME"


	echo "THE_PLAN_DIR_PATH=$THE_PLAN_DIR_PATH"


	echo "THE_BIN_DIR_NAME=$THE_BIN_DIR_NAME"
	echo "THE_BIN_DIR_PATH=$THE_BIN_DIR_PATH"

	echo "THE_EXT_DIR_NAME=$THE_EXT_DIR_NAME"
	echo "THE_EXT_DIR_PATH=$THE_EXT_DIR_PATH"

	echo "THE_VAR_DIR_NAME=$THE_VAR_DIR_NAME"
	echo "THE_VAR_DIR_PATH=$THE_VAR_DIR_PATH"

	echo "THE_PPA_DIR_NAME=$THE_PPA_DIR_NAME"
	echo "THE_PPA_DIR_PATH=$THE_PPA_DIR_PATH"

	echo "THE_WWW_DIR_PATH=$THE_WWW_DIR_PATH"

	echo "#"
	echo "#"
	echo "### Tail: var_dump #############################################################"
	echo
}
