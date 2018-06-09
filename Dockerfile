FROM r-base

# Add dependencies
RUN apt-get update && apt-get install -y libxml2 libxml2-dev libcurl4-gnutls-dev r-cran-rgl git

# Add dpclust(3p) dependencies
RUN R -q -e 'source("http://bioconductor.org/biocLite.R"); biocLite(c("VariantAnnotation","GenomicRanges,"Rsamtools","ggplot2","reshape2","VGAM"))'

# Preprocessing
git clone https://github.com/Wedge-Oxford/dpclust_smchet_docker
ADD dpclust_smchet_docker/dpclust3p_v1.0.6.tar.gz /opt/galaxy/tools/dpclust3p_v1.0.6.tar.gz 
RUN R -q -e 'install.packages("/opt/galaxy/tools/dpclust3p_v1.0.6.tar.gz", type="source", repos=NULL)'

# RC single pipeline
git clone https://github.com/sdentro/randomclone
ADD randomclone /opt/galaxy/tools/dpclust/randomclone
git clone https://github.com/sdentro/smchet_utils
ADD smchet_utils /opt/galaxy/tools/dpclust/smchet_utils
ADD randomclone_single.sh /opt/galaxy/tools/dpclust/randomclone_single.sh

# get mutation timer for the informed method
git clone https://github.com/sdentro/MutationTime.R
