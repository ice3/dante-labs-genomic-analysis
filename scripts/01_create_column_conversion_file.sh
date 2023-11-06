
######### 
# Create a column name conversion between DBsnp and Dante files 
#########
source /app/scripts/00_vars.sh

file_out=GCF_000001405.25_GRCh37.p13_assembly_report.chrnames
file_in=GCF_000001405.25_GRCh37.p13_assembly_report.txt

echo "Creating column conversion file..."
report_dir='ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405'
wget -N "${report_dir}/GCF_000001405.25_GRCh37.p13/GCF_000001405.25_GRCh37.p13_assembly_report.txt"
grep -e '^[^#]' $file_in | awk '{ print $7, $1 }' > $file_out
echo "...done"
echo "" 