# Once the DBsnp and Dante have the same chromosom name (steps 01 and 02)
# We can run the real annotation step 
source /app/scripts/00_vars.sh

echo `pwd` 

echo "Anotating Dante result with DBsnp..."
time bcftools annotate \
    --threads $NB_THREADS \
    -c ID \
    -a GCF_000001405.25.renamed_chr.vcf.gz dante.snp.vcf.gz \
> result.rs.vcf
echo "...done"