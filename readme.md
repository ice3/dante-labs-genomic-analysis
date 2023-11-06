# Dante Labs genomic analysis 

## Aim 

Perform some genetic analysis from a dante labs VCF file. 

For now, the analysis are: 
* geographic origin using Illumina AKT 
* disease detection using annotations from DBsnp 

We also aim to create a simple and reproducible analysis environment using docker and simple shell scripts. 

## How to run 

Tested on an AWS EC2 `c6a.8xlarge` running  with an attached volume (400 GiB, 10000 IO/s, rate 500)

1. prepare the data on the machine, from dante lab download VCF file and its index 
    * dante.snp.vcf.gz
    * dante.snp.vcf.gz.tbi 
1. clone this repo on the machine 
1. configure the VM (only done once): `make install_all`
1. perform the analysis: `make all`, this will create:
    * `1000G.pca.txt.png` with the PCA result 
    * `result.rs.vcf` your vcf enriched with the `rsid` from DBsnp and some basic analysis of this file 