#!/bin/bash

if (( $# < 1 )); then
  echo "usage:"
  echo "mousesuite {rodbfc|rodreg|mbe|mousebse|maskbackgroundnoise|rstr} [arguments]"
  echo "where [arguments] are the arguments for the invoked module"
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
  mbe)
    echo "launching mouse brain extractor"
    . /opt/MouseBrainExtractor/.venv/bin/activate
    export PYTHONPATH=$PYTHONPATH:/opt/MouseBrainExtractor/
    python3.11 /opt/MouseBrainExtractor/bin/run_mbe_predict_skullstrip_container.py $@
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

# $@
