#!/bin/sh


FASMG_INCLUDE="$1"
shift
FASMG_PATH="$1"
shift

CMD="INCLUDE=\"${FASMG_INCLUDE}\" ${FASMG_PATH} $@"
echo $CMD
eval $CMD
