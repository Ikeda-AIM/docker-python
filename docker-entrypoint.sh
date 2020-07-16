#!/bin/sh
cd ~
#日本語フォント設定
mkdir -p /usr/share/fonts/truetype/dejavu
cp ~/DejaVuSans.ttf /usr/share/fonts/truetype/dejavu
cp ~/ipag.ttf /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/fonts/ttf/
echo 'font.family : IPAGothic' >> /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/matplotlibrc
cp ~/rcmod.py /usr/local/lib/python3.6/dist-packages/seaborn/rcmod.py
rm -rf ~/.cache/matplotlib/*

#jupyterとtensorboard起動
#.bashrcへ移管→毎回起動してしまうので戻した
nohup jupyter lab --ip=0.0.0.0 --NotebookApp.password='sha1:7c24c0aead07:7b292ff7488a7452c19bd9681945061c20b02d40' --allow-root >> jupyter.log 2>&1 &
nohup tensorboard --logdir=./ --bind_all >> tensorboard.log 2>&1 &
exec "$@"