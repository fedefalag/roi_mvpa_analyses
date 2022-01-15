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

opt = designtwo_getOption_individualVisualRoi;

% Loop through subjects to create individual ROIs
for sub = 1:length(opt.subjects)
    
    % where do you want to save the new mask
    outputDir = strcat(opt.maskPath,'sub-',opt.subjects{sub},'/task-facelocalizerCombiemo_001unc/expand/');

    for roi = 1:length(opt.mask{sub}.coordinates)    
        
        % select MNI coordinates of current roi
        opt.sphere.location = opt.mask{sub}.coordinates{roi};
        
        % Choose action between - 1: expand sphere in provided cluster %
        % - 2: create a sphere from the provided peak coordinates %
        % - 3: do nothing as ROI either does not exist for that subj or has bw 100 and 150vx %
        if opt.mask{sub}.action{roi} == 1
            
            % where is the beta image to use as reference space
            betaImage = opt.betaPath; 
            
            % where is the cluster binary mask
            clusterMask = {strcat(opt.maskPath,'sub-',opt.subjects{sub},'/task-facelocalizerCombiemo_001unc/sub',opt.subjects{sub},opt.mask{sub}.roiname{roi},'mask.nii')};
            
            % when wanting to cross an expanding sphere with a cluster
            % cluster and sphere together in a struct
            specification  = struct( ...
                'mask1', clusterMask, ...
                'mask2', opt.sphere);
            
            % mask = createROI('expand', specificationOfClusterAndSPhere, dataImage, outputDirectory, logicalToSaveOrNot);
            mask = createRoi('expand', specification, betaImage, outputDir, opt.saveImg);
            
        elseif opt.mask{sub}.action{roi} == 2   
            
            % where is the beta image to use as reference space
            betaImage = opt.betaForSphere;
            
            % when wanting to create spheres:
            % sphere in a struct
            sphere.location = opt.sphere.location;
            sphere.radius = 10;
            
            specification = struct(...
                'sphere', sphere);
            
            % create simple spheres at the group coordinates
            mask = createRoi('sphere', sphere, betaImage, outputDir, opt.saveImg);
            
            
        elseif ~opt.mask{sub}.action{roi}
            
            doNothing = 1;
            
        end
        
        
    end
    
end
    
%end