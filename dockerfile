FROM ubuntu:22.04 
WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive

# install dependancies 
RUN apt update
RUN apt install -y build-essential git libbz2-dev libcurl4-openssl-dev imagemagick r-base wget

## fix imagemagick permissions to allow for pdf -> png conversion
RUN sed -i 's/^.*policy.*coder.*none.*PDF.*//' /etc/ImageMagick-6/policy.xml 

# install htslib
RUN git clone --recurse-submodules https://github.com/samtools/htslib.git
RUN cd htslib && make -j $(nproc)  && cd ..

# install bcftools
RUN git clone https://github.com/samtools/bcftools.git
RUN cd bcftools && make -j $(nproc) && cd ..

# install ATK
RUN git clone https://github.com/Illumina/akt.git
RUN cd akt && make -j $(nproc) no_omp && cd ..

# install Genetic-Trait-Detector (reports)
RUN git clone https://github.com/MichaelSebero/Genetic-Trait-Detector.git

RUN mkdir /app/scripts
ADD ./scripts/* /app/scripts
RUN chmod +x /app/scripts/*.sh 

CMD ["/bin/bash"]
