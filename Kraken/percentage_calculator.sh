PERCENTAGE=$(awk -F"\t" '$4 ~ /^S$/ && $6 ~ /Streptococcus agalactia7$/ { gsub(/^[ \t]+/, "", $1); printf "%.2f", $1 }' kraken*.txt)

if [ -z "${PERCENTAGE}" ]; then
    PERCENTAGE="0.00"
fi
if (( $(echo "$PERCENTAGE > 60.00" | bc -l) )); then
    TAXONOMY_QC="PASS"
    else
    TAXONOMY_QC="FAIL"
fi

echo PERCENTAGE_OF_STREPTOCOCCUS_READS=$PERCENTAGE
echo TAXONOMY_QC=$TAXONOMY_QC
