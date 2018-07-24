FROM r-base

# Add dependencies
RUN apt-get update && apt-get install -y libxml2 libxml2-dev libcurl4-gnutls-dev r-cran-rgl git libssl-dev

# Add dpclust(3p) dependencies
RUN R -q -e 'source("http://bioconductor.org/biocLite.R"); biocLite(c("stringi","VariantAnnotation","GenomicRanges","Rsamtools","ggplot2","reshape2","VGAM"))'

# Preprocessing
#RUN cd /opt/
RUN git clone https://github.com/Wedge-Oxford/dpclust_smchet_docker /opt/dpclust_smchet_docker
#ADD /opt/dpclust_smchet_docker/dpclust3p_v1.0.6.tar.gz /opt/galaxy/tools/dpclust3p_v1.0.6.tar.gz
#RUN R -q -e 'install.packages("/opt/galaxy/tools/dpclust3p_v1.0.6.tar.gz", type="source", repos=NULL)'
RUN R -q -e 'install.packages("/opt/dpclust_smchet_docker/dpclust3p_v1.0.6.tar.gz", type="source", repos=NULL)'

RUN mkdir -p /opt/galaxy/tools/dpclust/
# RC  pipeline
RUN git clone https://github.com/sdentro/randomclone /opt/randomclone
RUN cp -R /opt/randomclone /opt/galaxy/tools/dpclust/randomclone
RUN git clone https://github.com/sdentro/smchet_utils /opt/smchet_utils
#ADD /opt/smchet_utils /opt/galaxy/tools/dpclust/smchet_utils
RUN cp -R /opt/smchet_utils /opt/galaxy/tools/dpclust/smchet_utils
RUN git clone https://github.com/sdentro/randomclone_smchet_docker /opt/randomclone_smchet_docker
RUN cp /opt/randomclone_smchet_docker/randomclone_single.sh /opt/galaxy/tools/dpclust/randomclone_single.sh
RUN cp /opt/randomclone_smchet_docker/randomclone_informed.sh /opt/galaxy/tools/dpclust/randomclone_informed.sh

# get mutation timer for the informed method
RUN git clone https://github.com/sdentro/MutationTime.R /opt/MutationTime.R
RUN cp -R /opt/MutationTime.R /opt/galaxy/tools/dpclust/MutationTime.R
