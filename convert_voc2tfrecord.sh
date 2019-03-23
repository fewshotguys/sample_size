echo "making training dataset"
python3 /src/tensorflow/models/research/object_detection/dataset_tools/create_pascal_tf_record.py --logtostderr \
	--data_dir=/volume/data/voc/VOCdevkit \
	--year=merged \
	--set=trainval \
	--label_map_path=/volume/data/voc/pascal_label_map.pbtxt \
	--output_path=/volume/data/voc/tf/train_merged.record
echo "making validation dataset"
python3 /src/tensorflow/models/research/object_detection/dataset_tools/create_pascal_tf_record.py --logtostderr \
	--data_dir=/volume/data/voc/VOCdevkit \
	--year=VOC2007 \
	--set=test \
	--label_map_path=/volume/data/voc/pascal_label_map.pbtxt \
	--output_path=/volume/data/voc/tf/test_merged.record
