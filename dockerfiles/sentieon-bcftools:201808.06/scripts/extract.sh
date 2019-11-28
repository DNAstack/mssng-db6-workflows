#!/bin/bash

MAIN=$1
GRPS_CONF=$2
SAMPLES=$3
REGIONS=$4
BCF=bcftools

if [ $# -eq 4 ] || [ $# -eq 3 ]; then
  if [ "$REGIONS" == "" ]; then
    BED_ARG=""
  else
    BED_ARG="-R $REGIONS"
  fi
  #parse input files from group config file
  GRPS=$(grep -v "^#" $GRPS_CONF| cut -f1 | sort | uniq)
  $BCF view -h $MAIN | grep -v '^#CHROM' | grep -v '^##bcftools'
  hdr=$($BCF view -h $MAIN | grep '^#CHROM')
  hdr="$hdr\tFORMAT"
  arg="<($BCF view $BED_ARG -H -I $MAIN | cut -f -8)"
  col=9
  for g in $GRPS; do
    s=$($BCF view --force-samples -s $SAMPLES -h $g 2>/dev/null | grep '^#CHROM' |\
       cut -f 10-)
    [ -z "$s" ] && continue
    hdr="$hdr\t$s"
    c="<($BCF view --force-samples -s $SAMPLES $BED_ARG -H -I $g 2>/dev/null |\
      cut -f $col-)"
    arg="$arg $c"
    col=10
  done
echo -e "$hdr"
eval paste "$arg"
else
  echo "usage $0 main_vcf_file group_config_file csv_sample_list [bed_file]"
fi
