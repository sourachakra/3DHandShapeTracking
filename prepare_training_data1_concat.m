num_frames = num_data*3; %7627*3; %5970*36;%5970;
num_images_per_set = 3; %3
image_size = 64; %84
disp('Preparing images...');
trainImages_concat35 = zeros(image_size*num_images_per_set,image_size,1,num_frames,'uint8');

count = 1;
for i = 1:1:num_frames

    if mod(i,100) == 0
        i
    end
     dir_list = dir(['D:/souradeep/CLAPV1.0/binary_silhouettes_newmod12/silhouette_' num2str(i+240) '_binary/*.png']);

        for j = 1:num_images_per_set
%             j
%             ['D:/souradeep/CLAPV1.0/binary_silhouettes_newmod12/silhouette_' num2str(i) '_binary/' dir_list(j).name]
              im = imread(['D:/souradeep/CLAPV1.0/binary_silhouettes_newmod12/silhouette_' num2str(i+240) '_binary/' dir_list(j).name]);
              if ndims(im) == 3
                    grayim = rgb2gray(im);
              else
                    grayim = im;
              end
              
              
              croppedImage_mod = autocrop(grayim);
              grayim1 = imresize(croppedImage_mod,[image_size image_size]);
              grayim1 = grayim1 > 0.9*max(grayim1);
              grayim1 = grayim1*255;

              trainImages_concat35((j-1)*(image_size)+1:j*(image_size),:,1,count) = grayim1(:,:);
             
        end
%          imshow(trainImages_concat31(:,:,1,count));
%          pause(2);
        count = count + 1;
%  end
 
end



numim_per_frame = 3; %25
disp('Preparing paramaters...');
num_coeffs = 20;
trainParams15 = zeros(num_frames/numim_per_frame,num_coeffs*3);

V_1_mod = V_1_full(:,1:num_coeffs);
V_2_mod = V_2_full(:,1:num_coeffs);
V_3_mod = V_3_full(:,1:num_coeffs);
    
for i = 1:num_frames/numim_per_frame 
    
    LDprojection_1 = verticesinfo_diff_aug(i,:,1)*V_1_mod;
    LDprojection_2 = verticesinfo_diff_aug(i,:,2)*V_2_mod;
    LDprojection_3 = verticesinfo_diff_aug(i,:,3)*V_3_mod;

    trainParams15(i,1:num_coeffs) = LDprojection_1;
    trainParams15(i,num_coeffs+1:2*num_coeffs) = LDprojection_2;
    trainParams15(i,2*num_coeffs+1:3*num_coeffs) = LDprojection_3;

end


trainParams15_mod = zeros(num_frames,num_coeffs*3);

for i = 1:num_frames %num_frames
    trainParams15_mod(i,:) = trainParams15(ceil(i/numim_per_frame),:);
end


