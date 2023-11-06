.PHONY: install_deps oh_my_zsh docker_build docker_run

# ops stuff
install_deps:
	sudo yum -y install docker zsh && \
	 sudo systemctl start docker && \
	    sudo usermod -aG docker ${USER} && \
		 newgrp docker

oh_my_zsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install_all: install_deps oh_my_zsh

# tools stuff:
docker_build:
	docker build -t dante-analysis .

docker_run: docker_build
	docker rm -f dante-analysis; \
	docker run \
	-dit \
	--rm \
	-v .:/data \
	--name container-dante \
	dante-analysis \
	/bin/sh

docker_bash:
	docker exec -it container-dante /bin/bash

# bioinfo stuff starts now 
GCF_000001405.25.gz:
	# download the DBsnip (ncbi_data_DB_snp_25)
	wget https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.25.gz 
	wget https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.25.gz.tbi 


dante.snp.bcf:
	docker exec container-dante /bin/bash -c /app/scripts/11_create_bcf.sh 

GCF_000001405.25_GRCh37.p13_assembly_report.chrnames:
	docker exec container-dante /bin/bash -c /app/scripts/01_create_column_conversion_file.sh 

GCF_000001405.25.renamed_chr.vcf.gz:
	docker exec container-dante /bin/bash -c /app/scripts/02_annotate_reindex_snp_db.sh 

result.rs.vcf: GCF_000001405.25.renamed_chr.vcf.gz GCF_000001405.25_GRCh37.p13_assembly_report.chrnames
	docker exec container-dante /bin/bash -c /app/scripts/03_annotate_dante_file.sh 

1000G.pca.txt.png: dante.snp.bcf
	# create the ACP graph for origin analysis 
	docker exec container-dante /bin/bash -c /app/scripts/12_acp.sh  

genetic-detector: result.rs.vcf
	docker exec container-dante /bin/bash -c /app/scripts/21_genetic_detector.sh

all: docker_run GCF_000001405.25.gz 1000G.pca.txt.png genetic-detector