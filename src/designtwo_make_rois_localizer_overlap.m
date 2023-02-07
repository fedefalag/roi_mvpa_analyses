% Make ROIs of the face 
%
% Takes individual peak coordinates (from getOption function) 
% And cluster masks saved from the face localizer
% To create individual region masks with 150-200vx (see nrVoxels arg)
%
% data smoothed 2mm
% threhsold p < 0.001 unc.
%
% contrast faces > objects
%
%

% nrVoxels = [150];
% 
% for voxNr = 1:length(nrVoxels)

opt = designtwo_getOption_overlap;

% Loop through subjects to create individual ROIs
for roi = 1:length(opt.rois)
    
    % where do you want to save the new mask
    outputDir = strcat(opt.maskPath,'/label-intersection/');
        
        % select MNI coordinates of current roi
        opt.sphere.location = opt.sphere.allLocations{roi};        
            
            % where is the beta image to use as reference space
            betaImage = opt.betaPath; 
            
            % where is the cluster binary mask (overlap between the 2 localizers - contains 4+ clusters of interest tha t I am trying to separate) %
            clusterMask = {strcat(opt.maskPath,'/localizersOverlap',opt.rois{roi},'.nii')};
            
            % when wanting to cross an expanding sphere with a cluster
            % cluster and sphere together in a struct
            specification  = struct( ...
                'mask1', clusterMask, ...
                'mask2', opt.sphere);
            
%             % mask = createROI('expand', specificationOfClusterAndSPhere, dataImage, outputDirectory, logicalToSaveOrNot);
%             mask = createRoi('expand', specification, betaImage, outputDir, opt.saveImg);
              mask = createRoi('intersection', specification, betaImage, outputDir, opt.saveImg);         

    
end
    
%end