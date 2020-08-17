#!/usr/bin/env bash

# set directories for scripts.
INI_FILES=${INI:-"/etc/systemjack"}
SCRIPT_DIR=${SCRIPTS:-"/usr/lib/systemjack"}

# load functions and environment
. "${SCRIPT_DIR}/functions.sh"
. "${INI_FILES}/env.sh"

# and, go!
name=$1

eval `$READINI -i ${INI_FILES}/jack-webpeak.ini \
	${name}:ws=ws \
	${name}:delay=delay \
	${name}:iec268=iec268 \
	${name}:json=json \
	${name}:peak=peak \
	${name}:port=ports@`

json=${json:-"false"}


if [ -z $ws ]; then
	die "bad jack-webpeak configuration '${name}'"
else
	options+=" -n ${name} -w ${ws}"
fi

if is_true $json; then
	options+=" -j"
fi

if is_true $peak; then
	options+=" -p"
fi

if ! is_false $iec268; then
	options+=" -i ${iec268}"
fi

if ! is_false $delay; then
	options+=" -d ${delay}"
fi


if [ -z $ports ]; then
	die "no ports specified in jack-webpeak '${name}'"
fi
#else
	#for p in "${ports[@]}"; do
		#options+=" ${p}"
	#done
#fi


jackwebpeak=$(which jack-webpeak)

if [ -x $jackwebpeak ]; then
	exec $jackwebpeak $options "${ports[@]}"
else
	die "jack-webpeak not executable or not installed"
fi
