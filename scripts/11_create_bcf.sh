# Creates a BCF + index file from dante VCF 
source /app/scripts/00_vars.sh

echo "Creating BCF file from dante vcf file..."
bcftools convert dante.snp.vcf.gz -o dante.snp.bcf
bcftools index --threads $NB_THREADS dante.snp.bcf
echo "...done"