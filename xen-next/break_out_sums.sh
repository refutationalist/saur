#!/usr/bin/bash

build_stubdom=true build_qemu=true makepkg -g

source PKGBUILD

do_sums() {
	local name=$1
	shift
	local files=("$@")



	printf "\n\n%s=(\n" $name
	for file in "${files[@]}"; do

		if [[ $file == *"git"* ]]; then
			printf "\t\"SKIP\" # %s\n" $file
		else
			local bn=$(basename $file)
			local cksum=($(sha512sum "${bn}"))
			printf "\t\"%s\" # %s\n" $cksum $bn
		fi
	done
	printf ")\n\n"
}
canvas=""
canvas+="$(do_sums "_sha512sums"			"${_source[@]}")"
canvas+="$(do_sums "_patch_sums"			"${_patches[@]}")"
canvas+="$(do_sums "_feature_patch_sums"	"${_feature_patches[@]}")"
canvas+="$(do_sums "_stub_sums"			"${_stubdom_source[@]}")"

echo "$canvas" > tmp.sums
cp PKGBUILD PKGBUILD.new

# no lie, googled this.   When was the last time I needed to use ed?
ed -s PKGBUILD.new <<EOF
/# START SUMS/+,/# END SUMS/-d
/# START SUMS/ r tmp.sums
w
q
EOF

mv PKGBUILD.new PKGBUILD
rm tmp.sums

