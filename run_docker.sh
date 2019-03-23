PORT_NOTEBOOK=${1:-8888}
PORT_TENSORBOARD=${2:-6006}
nvidia-docker run -it --rm -p $PORT_NOTEBOOK:8888 -p $PORT_TENSORBOARD:6006 -v `pwd`/volume:/volume tf_object_detection jupyter lab --ip="0.0.0.0" --allow-root --no-browser
