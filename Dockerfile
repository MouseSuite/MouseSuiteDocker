FROM nvidia/cuda:13.0.1-cudnn-runtime-ubuntu24.04

RUN apt-get update &&  apt-get install -y --no-install-recommends \
    git wget software-properties-common libmagick++-dev \
    python3 python3-pip python3-venv python3-matplotlib python3-numpy \
    python-is-python3 python3-matplotlib python3-numpy python3-scipy

RUN python3 -m venv /opt/mouse_venv
    
RUN cd /opt && git clone https://github.com/MouseSuite/rodreg.git \
    && cd rodreg && /opt/mouse_venv/bin/pip install --no-cache-dir -r requirements.txt

RUN cd /opt && git clone https://github.com/MouseSuite/rodbfc.git \
    && cd rodbfc && /opt/mouse_venv/bin/pip install --no-cache-dir -r requirements.txt

RUN cd /opt/ && wget https://github.com/MouseSuite/MouseBSE/releases/download/v25a/mousebse_v25a_build_linux.tar.gz \
   && tar xf mousebse_v25a_build_linux.tar.gz && rm mousebse_v25a_build_linux.tar.gz

RUN cd /opt/ && wget https://github.com/MouseSuite/maskbackgroundnoise/releases/download/v25a/maskbackgroundnoise_v25a_build_linux.tar.gz \
    && tar xf maskbackgroundnoise_v25a_build_linux.tar.gz && rm maskbackgroundnoise_v25a_build_linux.tar.gz

RUN wget https://brainsuite.org/data/BIDS/BrainSuite23a_BIDS.tgz && tar xzvf BrainSuite23a_BIDS.tgz -C /opt/ && \
    rm BrainSuite23a_BIDS.tgz        

# Set up R environment for rstr
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9 \
    && apt-get update && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt-get update \
    && apt-get install -y dirmngr \
        libzmq3-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev \
        libpng-dev libtiff5-dev libjpeg-dev build-essential \
        libcurl4-openssl-dev libxml2-dev libssl-dev libfontconfig1-dev cmake  \
        r-base -y --assume-yes --allow-unauthenticated

RUN cd /opt && mkdir rstr && cd rstr \
    && wget https://github.com/MouseSuite/rstr/releases/download/v0.5.2/rstr_0.5.2.tar.gz \
    && Rscript -e 'install.packages(c("remotes", "iterators", "magrittr", "gtable", "htmlwidgets", "jsonlite", "pander", "rmarkdown", "DT", "ini", "RColorBrewer", "RNifti", "ggplot2", "scales", "doParallel", "foreach", "bit", "R6", "shinyjs", "lme4", "magick"))' \
    && Rscript -e 'install.packages("/opt/rstr/rstr_0.5.2.tar.gz", repos = NULL,  type = "source")'

RUN add-apt-repository -y ppa:deadsnakes/ppa && apt-get update \
    && apt-get install -y python3.11 python3.11-venv

RUN cd /opt && git clone https://github.com/MouseSuite/MouseBrainExtractor.git \
    && cd MouseBrainExtractor

COPY mbe_requirements.txt /opt/MouseBrainExtractor/requirements.txt

RUN cd /opt/MouseBrainExtractor && python3.11 -m venv .venv \
    && . .venv/bin/activate \
    && pip install -r requirements.txt

RUN cd / && wget http://users.bmap.ucla.edu/~yeunkim/rodentpipeline/pretrained_weights_rodseg.tar.gz && \
    tar xzvf pretrained_weights_rodseg.tar.gz && rm /pretrained_weights_rodseg.tar.gz

RUN touch /opt/MouseBrainExtractor/models/__init__.py

ENV PTWTS="/mod5/"

COPY bin /opt/bin

ENTRYPOINT [ "/opt/bin/mousesuite.sh"]