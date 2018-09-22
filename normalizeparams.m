trainParam_normalized15 = trainParams15_mod;
trainParam_normalized15_1 = trainParams15_mod;

meanval15 = zeros(num_coeffs*3,1);
maxval15 = zeros(num_coeffs*3,1);

for j = 1:size(trainParam_normalized15,2)
    meanval15(j) = mean(trainParam_normalized15(:,j));
end

for i = 1:size(trainParam_normalized15,1)
    for j = 1:size(trainParam_normalized15,2) 
      trainParam_normalized15(i,j) = trainParam_normalized15(i,j)-meanval15(j);
    end
end


for j = 1:size(trainParam_normalized15,2) 
    maxval15(j) = max(trainParam_normalized15(:,j));
end


for i = 1:size(trainParam_normalized15,1)
    for j = 1:size(trainParam_normalized15,2) 
      trainParam_normalized15_1(i,j) = trainParam_normalized15(i,j)/maxval15(j);
    end
end


