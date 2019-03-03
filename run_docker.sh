PORT=${1:-8888}
nvidia-docker run -it --rm -p $PORT:8888 -v `pwd`/volume:/volume tf_object_detection jupyter lab --ip="0.0.0.0" --allow-root --no-browser
