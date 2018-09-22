# 3DHandShapeTracking

The MATLAB code here is for the paper "Deep Multi-view 3D Hand-Shape Tracking"

Order of running the files to obtain the results:

1) Run "process_data.m"
2) Run "GetSilhouettes.m". This file internally calls the function in "GetSnapsmod_new.m".

3) Run "prepare_training_data1_concat.m" followed by "normalizeparams.m".
4) Run "learn_mapping.m" to train the CNN for pose estimation and 3D mesh reconstruction. 
