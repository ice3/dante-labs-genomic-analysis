# detect geographic origins from the 1000 genome information
# this generate a PNG graphic showing an ACP of genetic origins 

source /app/scripts/00_vars.sh

akt pca \
    --assume-homref \
    -W /app/akt/data/wgs.grch37.vcf.gz \
    dante.snp.bcf > 1000G.pca.txt 

Rscript /app/akt/scripts/1000G_pca.R 1000G.pca.txt
