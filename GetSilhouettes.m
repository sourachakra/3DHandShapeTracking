% function GetSilhouettes(frame_id,verticesinfo,facesinfo)
% function GetSilhouettes(verticesinfo,facesinfo)

warning('off','all')

restvertices = zeros(12327,3);

for frame_id = 1:1:7627 %7627

     frame_id

        for i = 1:12327
            restvertices(i,:) = verticesinfo(frame_id,i,:);
        end

%         stlwrite(['./stl_files/pose_' num2str(frame_id) '.stl'], facesinfo+1, restvertices);
%         mkdir(['./orig_silhouettes1/silhouette_' num2str(frame_id)]);
        
        GetSnapsmod_new(frame_id,['./all_stls/' num2str(frame_id) '.stl'],['./orig_silhouettes1/silhouette_' num2str(frame_id)]);

end

% end