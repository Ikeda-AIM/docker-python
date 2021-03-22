FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

LABEL maintainer="ikeda <ikeda@ai-ms.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 各環境変数を設定
ENV USER ikeda
ENV HOME /home/${USER}/docker
ENV SHELL /bin/bash

# 一般ユーザーアカウントを追加
RUN useradd -m ${USER}
# 一般ユーザーにsudo権限を付与
RUN gpasswd -a ${USER} sudo
# 一般ユーザーのパスワード設定
#RUN echo "${USER}:test_pass" | chpasswd
# ログインシェルを指定
#sed -i.bak -e "s/${HOME}:/${HOME}:${SHELL}" /etc/passwd

# 以降のRUN/CMDを実行するユーザー
USER ${USER}
# 以降の作業ディレクトリを指定
WORKDIR ${HOME}

RUN sudo apt update --fix-missing && \
    sudo apt install -y --no-install-recommends \
        sudo wget curl dpkg bzip2 ca-certificates libglib2.0-0 \
        libxext6 libsm6 libxrender1 git mercurial subversion \
        python3-dev python3-pip flake8 ffmpeg

# install PyTorch
RUN pip3 install -U pip && pip3 install setuptools && \
    pip3 install torch torchvision && \
    pip3 install pretrainedmodels tensorboard efficientnet-pytorch minio pytorch-gradcam albumentations pycocotools scikit-learn opencv-python mlflow xmltodict minio boto3 timm&& \
    pip3 install -U numpy==1.17.0 install pandas statsmodels seaborn jupyterlab xlrd ffmpeg-python

# link python3.6 to python
RUN ln -snf /usr/bin/python3.6 /usr/bin/python

COPY docker-entrypoint.sh /tmp
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/tmp/docker-entrypoint.sh"]
.2