r1 = csvread('vertex_data3.txt');
facesinfo = csvread('faces_data1.txt');
d = r1;
verticesinfo = zeros((size(r1,1)/12327)-80,12327,3);
count = 1;
for i = 1 : (size(r1,1)/12327)
    i
    for j = 1:12327
        if i >= 81
           verticesinfo(i-80,j,:) = d(count,:);
        end
        count = count + 1;
    end
end


num_data = 7547;

verticesinfo_aug = zeros(num_data*2,12327,3);
verticesinfo_aug(1:num_data,:,:) = verticesinfo(1:num_data,:,:);
verticesinfo_aug(num_data+1:2*num_data,:,:) = verticesinfo(1:num_data,:,:);
verticesinfo_aug(2*num_data+1:3*num_data,:,:) = verticesinfo(1:num_data,:,:);


basexyz = verticesinfo_aug(1,:,:);
verticesinfo_diff_aug = verticesinfo_aug;
for i = 1:size(verticesinfo_aug,1)
   verticesinfo_diff_aug(i,:,:) = verticesinfo_aug(i,:,:) - basexyz;
end

disp('Building PCA space...');

k = 20;
i1 = 2;
disp('for x coord...');
[U_1_full, S_1_full, V_1_full] = fsvd(verticesinfo_diff_aug(:,:,1), k, i1, true);
disp('for y coord...');
[U_2_full, S_2_full, V_2_full] = fsvd(verticesinfo_diff_aug(:,:,2), k, i1, true);
disp('for z coord...');
[U_3_full, S_3_full, V_3_full] = fsvd(verticesinfo_diff_aug(:,:,3), k, i1, true);

