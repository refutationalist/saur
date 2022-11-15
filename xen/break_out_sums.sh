#!/usr/bin/bash

build_stubdom=true build_qemu=true makepkg -g

source PKGBUILD

do_sums() {
	local name=$1
	shift
	local files=("$@")



	echo "${name}=("
	for file in "${files[@]}"; do

		if [[ $file == *"git"* ]]; then
			echo -e "\t\"SKIP\""
		else
			local bn=$(basename $file)
			local cksum=($(sha512sum "${bn}"))
			printf "\t\"%s\" # %s\n" $cksum $bn
		fi
	done
	printf ")\n\n\n"
}

echo "## START HERE"
do_sums "_sha512sums" "${_source[@]}"
do_sums "_patch_sums" "${_patches[@]}"
do_sums "_stub_sums" "${_stubdom_source[@]}"
echo "## END HERE"
