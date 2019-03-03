FROM tensorflow/tensorflow:latest-gpu-py3

RUN apt-get update && apt-get install -y \
  protobuf-compiler \
  python3-pil \
  python3-lxml \
  python3-tk \
  git \
  wget \
  vim \
  # needed by pillow-simd
  zlib1g-dev \
  libjpeg-turbo8-dev

RUN pip3 install --upgrade pip && pip install \
  Cython \
  contextlib2 \
  pillow \
  lxml \
  matplotlib \
  seaborn

RUN pip uninstall -y pillow && \
	CC="cc -mavx2" pip install --force-reinstall pillow-simd

# install jupyter and nodejs for jupyter lab extensions
# https://github.com/jupyter/notebook/issues/4439
RUN pip uninstall tornado && pip install tornado==5.1.1 \
 && curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs \
 && pip install jupyter \
 && pip install jupyterlab \
 && pip install jupyter_contrib_nbextensions \
 && jupyter contrib nbextension install --system \
 && pip install ipyvolume \
 && jupyter labextension install @jupyter-widgets/jupyterlab-manager

RUN mkdir src
WORKDIR src

COPY tensorflow /src/tensorflow

# install pycocotools
RUN git clone https://github.com/cocodataset/cocoapi.git \
  && cd cocoapi/PythonAPI \
  && make \
  && cp -r pycocotools /src/tensorflow/models/research/

# compile protobuf
WORKDIR /src/tensorflow/models/research/
RUN wget -O protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip \
  && unzip protobuf.zip \
  && ./bin/protoc object_detection/protos/*.proto --python_out=.
ENV PYTHONPATH $PYTHONPATH:/src/tensorflow/models/research/:/src/tensorflow/models/research/slim

WORKDIR /
