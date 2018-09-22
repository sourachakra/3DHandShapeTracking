function GetSnapsmod_new(frame_id,stlfile,output_folder)


%% Load STL mesh

model = stlread(stlfile);


%% Render
% The model is rendered with a PATCH graphics object. We also add some dynamic
% lighting, and adjust the material properties to change the specular
% highlighting.


% Add a camera light, and tone down the specular highlighting
patch(model,'FaceColor',       [1 0.7 0.7], ...
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15, 'DiffuseStrength', 0.07, 'Edgelighting', 'gouraud');
% size(model.vertices)
% ct = camtarget;
% rotate(surf(model.vertices),[1,1,0],10)
% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
figure(1);
axis('image');
view([0 0]);
% grid off
 set(gca, 'visible', 'off') ;

cam_dist = 25;
hand_dist = 40;

cam_angle = 180*atan(cam_dist/hand_dist)/(2*pi);


phase_count = 1;
    

   phase_diff_theta = -45;
   phase_diff_phi = 0;

    for diff_theta = -cam_angle:cam_angle:cam_angle %-30:30:30

         
        count = 1;
        

             for dtheta = 0:-cam_angle:-7*cam_angle
    

                    camproj('perspective');
                    view([phase_diff_phi phase_diff_theta]);
                    
                    
                    
                    
                    camorbit(-(dtheta+diff_theta)/2,0,'camera')

                    CurrentImage = getframe(gca);
                    ImageData = CurrentImage.cdata; 

                    ImageData_binary = rgb2gray(ImageData);

                    
                    ImageData_binary(ImageData_binary == ImageData_binary(1,1)) = 0;
                    ImageData_binary(ImageData_binary ~= ImageData_binary(1,1)) = 256;


                    f = flipud(fliplr(ImageData_binary));

                    mkdir(['./binary_silhouettes_newmod12/silhouette_' num2str((frame_id-1)*3+phase_count) '_binary']);

                    if(count==1 || count == 4 || count == 6)
                        if count==1 
                            count_mod = 1;
                        elseif count == 4
                            count_mod = 2;
                        else
                            count_mod = 3;
                        end
                        imwrite(imresize(f,[64 64]),['./binary_silhouettes_newmod12/silhouette_' num2str((frame_id-1)*3+phase_count) '_binary/' num2str(count_mod) '.png']);
                    end
                 
                    count = count + 1;

            end
     

        phase_count = phase_count + 1;

     end



close(gcf);
end
