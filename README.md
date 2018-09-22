# 3DHandShapeTracking

The MATLAB code here is for the paper "Deep Multi-view 3D Hand-Shape Tracking" currently in submission.

Prior to using this software, please download the 'vertex_data3.txt' file from the link: 

Order of running the files to obtain the results:

1) Run "process_data.m" to process the vertex and face data of the hand meshes and obtain the low-dimensional subspace.
2) Run "GetSilhouettes.m" to generate the silhouettes. This file internally calls the function in "GetSnapsmod_new.m".

3) Run "prepare_training_data1_concat.m" followed by "normalizeparams.m" to prepare training CNN from the low-dimensional space generated and the generated silhouettes.

4) Run "learn_mapping.m" to train the CNN for pose estimation and test the network on test data to obtain the 3D mesh reconstruction. 
