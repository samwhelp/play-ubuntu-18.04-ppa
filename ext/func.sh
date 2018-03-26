

### Head: util_debug ###########################################################
#
util_debug_echo () {
	if is_debug; then
		echo "$@" 1>&2;
	fi
}
#
### Head: util_debug ###########################################################


### Head: main_func ############################################################
#
func_help () {
	cat <<EOF

Usage:

$ make [command]

Ex:

$ make
$ make help

$ make update

$ make info

$ make serve

$ make sources-list-install
$ make sources-list-remove

$ make localhost-sources-list-install
$ make localhost-sources-list-remove

$ make github-sources-list-install
$ make github-sources-list-remove

Debug:

$ export DEBUG_PLAY_PPA=true

EOF
}

func_prepare () {
	echo
	echo "sudo apt-get install dpkg-dev php-cli"
	sudo apt-get install dpkg-dev php-cli

	## $ dpkg -S $(which dpkg-scanpackages)
	## dpkg-dev: /usr/bin/dpkg-scanpackages

	## $ dpkg -S $(which dpkg-scansources)
	## dpkg-dev: /usr/bin/dpkg-scansources
}

func_serve () {
	util_web_serve
}

func_create () {
	util_ppa_create_skel_dir
}

func_update () {
	util_ppa_scan_packages
}

func_info () {
	util_ppa_tree_root_dir
}

func_file_sources_list_install () {
	util_apt_file_sources_list_install
}

func_file_sources_list_remove () {
	util_apt_file_sources_list_remove
}

func_localhost_sources_list_install () {
	util_apt_localhost_sources_list_install
}

func_localhost_sources_list_remove () {
	util_apt_localhost_sources_list_remove
}

func_github_sources_list_install () {
	util_apt_github_sources_list_install
}

func_github_sources_list_remove () {
	util_apt_github_sources_list_remove
}
#
### Tail: main_func ############################################################


### Head: util_web #############################################################
#
util_web_serve () {
	cd "$THE_WWW_DIR_PATH"

	## http://php.net/manual/en/features.commandline.webserver.php
	php -S localhost:8088
}

### Tail: util_web #############################################################


### Head: util_ppa #############################################################
#
util_ppa_create_skel_dir () {

	local dir_name

	## create repository root dir
	echo
	echo "mkdir -p $THE_PPA_DIR_PATH"
	mkdir -p "$THE_PPA_DIR_PATH"

	## cd repository root dir
	echo
	echo "cd $THE_PPA_DIR_PATH"
	cd "$THE_PPA_DIR_PATH"


	## create sub dir
	mkdir -p dists/bionic/main/binary-i386
	mkdir -p dists/bionic/main/binary-amd64
	mkdir -p dists/bionic/main/source

	for dir_name in {a..z}; do
		mkdir -p pool/main/$dir_name
	done

	## tree "$THE_PPA_DIR_PATH"
}

util_ppa_scan_packages () {

	## cd repository root dir
	echo
	echo "cd $THE_PPA_DIR_PATH"
	cd "$THE_PPA_DIR_PATH"


	## binary package
	dpkg-scanpackages --arch=i386 pool/main | gzip -9c > dists/bionic/main/binary-i386/Packages.gz
	dpkg-scanpackages --arch=amd64 pool/main | gzip -9c > dists/bionic/main/binary-amd64/Packages.gz

	## source package
	dpkg-scansources pool/main | gzip -9c > dists/bionic/main/source/Sources.gz
}

util_ppa_tree_root_dir () {

	## cd plan root dir
	echo
	echo "cd $THE_PLAN_DIR_PATH"
	cd "$THE_PLAN_DIR_PATH"

	tree ubuntu
}
#
### Tail: util_ppa #############################################################


### Head: util_apt #############################################################
#
util_apt_file_sources_list_install () {

	## create var dir
	echo
	echo "mkdir -p $THE_VAR_DIR_PATH/sources.list.d"
	mkdir -p "$THE_VAR_DIR_PATH/sources.list.d"

	## cd var dir
	echo
	echo "cd $THE_VAR_DIR_PATH/sources.list.d"
	cd "$THE_VAR_DIR_PATH/sources.list.d"
	#pwd


	## https://help.ubuntu.com/community/Repositories/Personal
	## https://help.ubuntu.com/community/AptGet/Offline/Repository
	## deb file:///home/repository SuiteCodename main restricted universe multiverse

	## /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list
	## deb [trusted=yes] file:///home/user/project/play-ubuntu-18.04-ppa/ubuntu bionic main

cat > play-ubuntu-18.04-ppa-file.list <<EOF
deb [trusted=yes] file://$THE_PPA_DIR_PATH bionic main
deb-src [trusted=yes] file://$THE_PPA_DIR_PATH bionic main

EOF

	echo
	echo "sudo cp play-ubuntu-18.04-ppa-file.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list"
	sudo cp play-ubuntu-18.04-ppa-file.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update
}

util_apt_file_sources_list_remove () {

	## remove /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list
	echo
	echo "sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list"
	sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-file.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update

}


util_apt_localhost_sources_list_install () {

	## create var dir
	echo
	echo "mkdir -p $THE_VAR_DIR_PATH/sources.list.d"
	mkdir -p "$THE_VAR_DIR_PATH/sources.list.d"

	## cd var dir
	echo
	echo "cd $THE_VAR_DIR_PATH/sources.list.d"
	cd "$THE_VAR_DIR_PATH/sources.list.d"
	#pwd


cat > play-ubuntu-18.04-ppa-localhost.list <<EOF
deb [trusted=yes] http://localhost:8088/ubuntu bionic main
deb-src [trusted=yes] http://localhost:8088/ubuntu bionic main

EOF

	echo
	echo "sudo cp play-ubuntu-18.04-ppa-localhost.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-localhost.list"
	sudo cp play-ubuntu-18.04-ppa-localhost.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-localhost.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update
}

util_apt_localhost_sources_list_remove () {

	## remove /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-localhost.list
	echo
	echo "sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-localhost.list"
	sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-localhost.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update

}

util_apt_github_sources_list_install () {

	## create var dir
	echo
	echo "mkdir -p $THE_VAR_DIR_PATH/sources.list.d"
	mkdir -p "$THE_VAR_DIR_PATH/sources.list.d"

	## cd var dir
	echo
	echo "cd $THE_VAR_DIR_PATH/sources.list.d"
	cd "$THE_VAR_DIR_PATH/sources.list.d"
	#pwd


cat > play-ubuntu-18.04-ppa-github.list <<EOF
deb [trusted=yes] https://samwhelp.github.io/play-ubuntu-18.04-ppa/ubuntu bionic main
deb-src [trusted=yes] https://samwhelp.github.io/play-ubuntu-18.04-ppa/ubuntu bionic main

EOF

	echo
	echo "sudo cp play-ubuntu-18.04-ppa-github.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list"
	sudo cp play-ubuntu-18.04-ppa-github.list /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update
}

util_apt_github_sources_list_remove () {

	## remove /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list
	echo
	echo "sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list"
	sudo rm -f /etc/apt/sources.list.d/play-ubuntu-18.04-ppa-github.list

	echo
	echo "sudo apt-get update"
	sudo apt-get update

}
#
### Head: util_apt #############################################################
