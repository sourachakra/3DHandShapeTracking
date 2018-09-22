warning('off','all')

restvertices = zeros(12327,3);

for frame_id = 81:7627 

     frame_id

        for i = 1:12327
            restvertices(i,:) = verticesinfo(frame_id,i,:);
        end
        
        GetSnapsmod_new(frame_id,['./all_stls/' num2str(frame_id) '.stl'],['./orig_silhouettes1/silhouette_' num2str(frame_id)]);

end

