# ncbi-one-liners
A collection of NCBI one-liners

*Example input*

    SAMPLE=PNUSAC017705

## Get SRR identifiers from sample names

        echo PNUSAC017705 | \
          esearch -db biosample -query $SAMPLE | \
          elink --target sra | \
          efetch -format xml | \
          xtract -pattern EXPERIMENT_PACKAGE -element SAMPLE@alias -element RUN@accession -block DESIGN | \
          awk -v ID="$SAMPLE" '{print ID"\t"$0}';

