# The DBsnp file chromosome name don't match Dante one
# We need to change the chromosom names using the  
# conversion file created in step 01 

source /app/scripts/00_vars.sh

echo "Anotating the DBsnp (can take a while)..."
time bcftools annotate \
    --threads $NB_THREADS \
    --rename-chrs GCF_000001405.25_GRCh37.p13_assembly_report.chrnames \
    GCF_000001405.25.gz \
    -o GCF_000001405.25.renamed_chr.vcf.gz
echo "...done"
echo ""
# bgzip --threads 32 -i GCF_000001405.25.renamed_chr.vcf

echo "Reindexing new DBsnp..."
time bcftools index --threads $NB_THREADS GCF_000001405.25.renamed_chr.vcf.gz
echo "...done"
echo ""