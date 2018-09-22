
image_size = 64;
num_params = 12*3;
num_images_per_set = 3;

vertexnow = zeros(12327,3,7627);


disp('Load training data...');


% network design
layers = [ ...
    imageInputLayer([image_size*num_images_per_set image_size 1])
    
    convolution2dLayer(3,12)
    reluLayer
    
    
    convolution2dLayer(3,16)
    reluLayer
    
    

    convolution2dLayer(3,32)
    reluLayer
    
    
    convolution2dLayer(3,32)
    reluLayer
    
    %crossChannelNormalizationLayer(1, 'K', 1)
  % maxPooling2dLayer(2,'Stride',1)
    


    fullyConnectedLayer(num_params*4)
    fullyConnectedLayer(num_params*2)
    fullyConnectedLayer(num_params)
    regressionLayer];


% options = trainingOptions('sgdm','InitialLearnRate',0.000001, ...
%     'MaxEpochs',150);

options = trainingOptions('sgdm',...
      'InitialLearnRate', 0.005, ...  %0.005
      'LearnRateSchedule','piecewise',...
      'LearnRateDropFactor',0.4,... 
      'LearnRateDropPeriod',13,... 
      'MaxEpochs',90,... 
      'MiniBatchSize',32,...,
      'Shuffle','once',...
      'CheckpointPath','./checkpoint/',...
      'OutputFcn',@plotTrainingAccuracy);
  
% training network
disp('Training network...');
net = trainNetwork(trainImages_concat31(:,:,1,1:num_frames),trainParam_normalized15_1(1:1:num_frames,1:num_params),layers,options);
%  




%% testing network

% test_data_range = 5260:50:5770; %5360:100:5970;
test_data_range = 5970;%5970;%5390:5390;%5260:50:5770; %5360:100:5970;
% testImages = zeros(image_size*3,image_size,1,1);
% loading test data
testImages = trainImages_concat31(:,:,1,1:36:test_data_range*36);


% testImages = testImages_concat31(:,:);
testParams = trainParams15_mod(1:test_data_range,1:num_params);
% [testImages,~,testParams] = digitTest4DArrayData;
 net1 = load('./checkpoint/gg8_more_sim_fit.mat'); %supernet_3images.mat
disp('stage reached');


predictedParams = predict(net1.net,testImages);
%  predictedParams = predict(net,testImages);
for i = 1:size(predictedParams,1)
    
    for j = 1:size(predictedParams,2)
       % predictedParams(i,j) = predictedParams(i,j)*maxval(1)/10;
        predictedParams(i,j) = predictedParams(i,j)*maxval15(j) + meanval15(j);
    end
end

% for i = 1:5970
%     
% end

%% pose reconstruction from estimated parameters


num_coeffs = num_params/3;

for k = 1:test_data_range %first test parameter
k
    V_1_mod = V_1(:,1:num_coeffs);
    V_2_mod = V_2(:,1:num_coeffs);
    V_3_mod = V_3(:,1:num_coeffs);

    LDprojection_1 = predictedParams(k,1:num_coeffs);
    LDprojection_2 = predictedParams(k,num_coeffs+1:2*num_coeffs);
    LDprojection_3 = predictedParams(k,2*num_coeffs+1:3*num_coeffs);

    def_1 = LDprojection_1*V_1_mod';
    def_2 = LDprojection_2*V_2_mod';
    def_3 = LDprojection_3*V_3_mod';

    vertex_current = zeros(12327,3);

    for i = 1:12327
        for j = 1:3
            if j == 1
                    vertex_current(i,j) = verticesinfo(1,i,j) + def_1(1,i);
            elseif j == 2
                    vertex_current(i,j) = verticesinfo(1,i,j) + def_2(1,i);
            else
                    vertex_current(i,j) = verticesinfo(1,i,j) + def_3(1,i);
            end


        end
    end

    stlwrite(['./predicted_poses/predicted_pose_' num2str(k) '.stl'], facesinfo+1, vertex_current);


        for j = 1:12327
            for k1 = 1:3
                vertexnow(j,k1,k) = vertex_current(j,k1);
            end
        end

end




%% plot function
function plotTrainingAccuracy(info)

persistent plotObj

if info.State == "start"
    plotObj = animatedline;
    xlabel("Iteration")
    ylabel("Training Accuracy")
elseif info.State == "iteration"
    addpoints(plotObj,info.Iteration,info.TrainingAccuracy)
    drawnow limitrate nocallbacks
end

end
