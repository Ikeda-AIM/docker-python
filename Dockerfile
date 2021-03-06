FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

LABEL maintainer="ikeda <ikeda@ai-ms.com>"

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# apt install
RUN apt update --fix-missing && \
    apt install -y --no-install-recommends \
        sudo wget curl dpkg bzip2 ca-certificates libglib2.0-0 \
        libxext6 libsm6 libxrender1 git mercurial subversion \
        python3-dev python3-pip flake8 ffmpeg iputils-ping net-tools gcc

# install PyTorch
RUN pip3 install -U pip && pip3 install setuptools && \
    pip3 install torch torchvision cython && \
    pip3 install pretrainedmodels tensorboard efficientnet-pytorch minio pytorch-gradcam albumentations pycocotools scikit-learn opencv-python mlflow xmltodict minio boto3 timm && \
    pip3 install numpy pandas pandarallel statsmodels seaborn jupyterlab xlrd ffmpeg-python moviepy

# link python3.6 to python
RUN ln -snf /usr/bin/python3.6 /usr/bin/python

COPY docker-entrypoint.sh /tmp
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/tmp/docker-entrypoint.sh"]
