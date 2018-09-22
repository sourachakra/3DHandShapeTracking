# 3DHandShapeTracking

The MATLAB code here is for the paper "Deep Multi-view 3D Hand-Shape Tracking" currently in submission.

Prior to using this software, please download the 'vertex_data3.txt' file and 'all_stls.zip' files from the link: 

https://drive.google.com/file/d/1dc2lzlr1m5eiwXTqoGWv8yC6cztuC_KQ/view?usp=sharing

Unzip 'all_stls.zip' and place the folder into the root directory.

Order of running the files to obtain the results:

1) Run "process_data.m" to process the vertex and face data of the hand meshes and obtain the low-dimensional subspace.
2) Run "GetSilhouettes.m" to generate the silhouettes. This file internally calls the function in "GetSnapsmod_new.m".

3) Run "prepare_training_data1_concat.m" followed by "normalizeparams.m" to prepare data for training CNN from the low-dimensional space generated and the generated silhouettes.

4) Run "learn_mapping.m" to train the CNN for pose estimation and test the network on test data to obtain the 3D mesh reconstruction. 
