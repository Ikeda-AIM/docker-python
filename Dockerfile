FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

LABEL maintainer="ikeda <ikeda@ai-ms.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# apt install
RUN apt update --fix-missing && \
    apt install -y --no-install-recommends \
        sudo wget curl dpkg bzip2 ca-certificates libglib2.0-0 \
        libxext6 libsm6 libxrender1 git mercurial subversion \
        python3-dev python3-pip flake8 ffmpeg iputils-ping net-tools

# install PyTorch
RUN pip3 install -U pip && pip3 install setuptools && \
    pip3 install torch torchvision && \
    pip3 install pretrainedmodels tensorboard efficientnet-pytorch minio pytorch-gradcam albumentations pycocotools scikit-learn opencv-python mlflow xmltodict minio boto3 timm&& \
    pip3 install -U numpy==1.17.0 install pandas statsmodels seaborn jupyterlab xlrd ffmpeg-python

# link python3.6 to python
RUN ln -snf /usr/bin/python3.6 /usr/bin/python

#sudoの設定
RUN sed -i -e 's/# %wheel\tALL=(ALL)\tNOPASSWD: ALL/%wheel\tALL=(ALL)\tNOPASSWD: ALL/' /etc/sudoers
RUN sed -i -e 's/%wheel\tALL=(ALL)\tALL/# %wheel\tALL=(ALL)\tALL/' /etc/sudoers
RUN visudo -c

COPY docker-entrypoint.sh /tmp
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/tmp/docker-entrypoint.sh"]