python3 /src/tensorflow/models/research/object_detection/model_main.py \
    --pipeline_config_path=/volume/models/mobilenet_v2_merged_trainval/ssd_mobilenet_v2_voc_eval.config \
    --model_dir=. \
    --checkpoint_dir=/volume/models/mobilenet_v2_merged_trainval \
    --num_training_steps=0 \
    --run_once=true \
    --alsologtostderr
