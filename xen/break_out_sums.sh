#!/usr/bin/bash

source PKGBUILD

do_sums() {
	local name=$1
	shift
	local files=("$@")


	echo "${name}=("
	for file in "${files[@]}"; do
		local bn=$(basename $file)
		local cksum=($(sha512sum "${bn}"))
		printf "\t\"%s\" # %s\n" $cksum $bn
	done
	printf ")\n\n\n"
}

do_sums "_sha512sums" "${_source[@]}"
do_sums "_patch_sums" "${_patches[@]}"
do_sums "_stub_sums" "${_stubdom_source[@]}"
