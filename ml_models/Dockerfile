FROM python:3.7

# aptとpipの更新
RUN apt update && apt -y upgrade

# mecabとmecab-ipadic-NEologdの導入
RUN apt install -y mecab
RUN apt install -y libmecab-dev
RUN apt install -y mecab-ipadic-utf8
RUN apt install -y git
RUN apt install -y make
RUN apt install -y curl
RUN apt install -y xz-utils
RUN apt install -y file
RUN apt install -y sudo
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd /mecab-ipadic-neologd && ./bin/install-mecab-ipadic-neologd -n -y

# pythonのライブラリ
WORKDIR /home
COPY requirements.txt ${PWD}
RUN python3.7 -m pip install -r requirements.txt
# YAKE! model
RUN python3.7 -m pip install git+https://github.com/LIAAD/yake
# 多重対応分析
RUN python3.7 -m pip install --user mca

# 作業ディレクトリ
WORKDIR /home/workspace