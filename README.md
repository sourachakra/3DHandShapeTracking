# 3DHandShapeTracking

The MATLAB code here is for the paper "Deep Multi-view 3D Hand-Shape Tracking" currently in submission. MATLAB 2017b was used
for implemeting this code.

Prior to using this software, please download the 'vertex_data3.txt' file from the link and place in the root directory: 

https://drive.google.com/file/d/1dc2lzlr1m5eiwXTqoGWv8yC6cztuC_KQ/view?usp=sharing

Download 'all_stls.zip' file from the following link:

https://drive.google.com/file/d/18UoeyLu8NizTe7pXfc7iYYoHXR9TF_LL/view?usp=sharing

Unzip 'all_stls.zip' and place the folder into the root directory.

Order of running the files to obtain the results:

1) Run "process_data.m" to process the vertex and face data of the hand meshes and obtain the low-dimensional subspace.
2) Run "GetSilhouettes.m" to generate the silhouettes. This file internally calls the function in "GetSnapsmod_new.m".

3) Run "prepare_training_data1_concat.m" followed by "normalizeparams.m" to prepare data for training CNN from the low-dimensional space generated and the generated silhouettes.

4) Run "learn_mapping.m" to train the CNN for pose estimation and test the network on test data to obtain the 3D mesh reconstruction. For testing the network, please provide the path to the trained model (saved in '.mat' format) i.e replace the line "net1 = load('./checkpoint/gg8_more_sim_fit.mat');" in line 69 in file "learn_mapping.m" with the path to the trained model.


