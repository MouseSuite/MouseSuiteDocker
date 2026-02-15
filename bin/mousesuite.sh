#!/bin/bash

if (( $# < 1 )); then
    echo "usage:"
    echo "mousesuite [rodbfc|rodreg|mousebse|maskbackgroundnoise|rstr] {arguments}"
    exit 0
fi

cmd=$1
shift

case $cmd in

    -h|--help|help)
            echo "choose one of rodbfc, rodreg, mousebse, or maskbackgroundnoise"
            ;;
    rodbfc)
            echo "launching rodbfc"
            /opt/bin/rodbfc.sh $@
            ;;
    rodreg)
            echo "launching rodreg"
            /opt/bin/rodreg.sh $@            
            ;;
    mousebse)
            echo "launching mousebse"
            /opt/mousebse/mousebse $@
            ;;
    maskbackgroundnoise)
            echo "launching maskbackgroundnoise"
            /opt/maskbackgroundnoise/maskbackgroundnoise $@            
            ;;
    rstr)
            echo "launching rstr"
            R            
            ;;            
    *)
            echo "unrecognized command $cmd"
            exit 1
            ;;
esac

$@
