FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

LABEL maintainer="ikeda <ikeda@ai-ms.com>"

RUN apt update --fix-missing && \
    apt install -y --no-install-recommends \
        sudo wget curl dpkg bzip2 ca-certificates libglib2.0-0 \
        libxext6 libsm6 libxrender1 git mercurial subversion \
        python3-dev python3-pip flake8

# install PyTorch
RUN pip3 install -U pip && pip3 install setuptools && \
    pip3 install torch torchvision && \
    pip3 install pretrainedmodels tensorboard efficientnet-pytorch minio pytorch-gradcam albumentations pycocotools scikit-learn opencv-python mlflow minio boto3 && \
    pip3 install -U numpy==1.17.0 && \
    pip3 install pandas statsmodels seaborn jupyterlab

# link python3.6 to python
RUN ln -snf /usr/bin/python3.6 /usr/bin/python

COPY docker-entrypoint.sh /tmp
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/tmp/docker-entrypoint.sh"]
