#! /bin/sh
# https://github.com/bats-core/bats-core

@test edirectExists {
  exe=$(which esearch)
  [ "$exe" != "" ]

}

@test queryIsolatesToSrr {
  # PNUSAC017705    PNUSAC017705    SRR12396687
  # PNUSAC017702    PNUSAC017702    SRR12396689
  # PNUSAC017523    PNUSAC017523    SRR12346709

  SAMPLE=PNUSAC017705
  ROW=$(
    echo "$SAMPLE" | \
      esearch -db biosample -query $SAMPLE | \
      elink --target sra | \
      efetch -format xml | \
      xtract -pattern EXPERIMENT_PACKAGE -element SAMPLE@alias -element RUN@accession -block DESIGN | \
      awk -v ID="$SAMPLE" '{print ID"\t"$0}';
  )

  sample=$(echo "$ROW" | cut -f 2)
  SRR=$(echo "$ROW" | cut -f 3)
  
  [ "PNUSAC017705" == "$sample" ] && [ "SRR12396687" == "$SRR" ]
}

