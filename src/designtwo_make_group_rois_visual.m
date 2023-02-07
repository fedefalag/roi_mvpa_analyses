% Make ROIs of the face 
%
% example script, makes only STS masks
%
% individual peak coordinates and cluster masks are taken from the face localizer
% data smoothed 2mm
% threhsold p < 0.005 unc.
%
% contrast faces > objects
%
%

nrVoxels = [150];

for voxNr = 1:length(nrVoxels)

opt = designtwo_getOption_visualRoi(nrVoxels(voxNr));

    for sub = 1:length(opt.groups)      

        for roi = 1:length(opt.rois)      
            
            % select MNI coordinates of current  roi
            opt.sphere.location = opt.sphere.allLocations{roi};

            % where is the cluster binary mask
            clusterMask = {strcat(opt.maskPath,opt.maskName,'.nii')};

            % where is the beta image to use as reference space
            betaImage = strcat(opt.dataPath,'sub-',opt.subjects{sub},opt.betaPath,num2str(opt.eventFWHM),'/beta0001.nii');

            % where do you want to save the new mask
            outputDir = strcat(opt.maskPath,'masks/');
            
%             % when wanting to cross an expanding sphere with a cluster
%             % cluster and sphere together in a struct
%             specification  = struct( ...
%                 'mask1', clusterMask, ...
%                 'mask2', opt.sphere);
% 
%             % mask = createROI('expand', specificationOfClusterAndSPhere, dataImage, outputDirectory, logicalToSaveOrNot);
%             mask = createRoi('expand', specification, betaImage, outputDir, opt.saveImg);


            % when wanting to create spheres:
            % sphere in a struct
            sphere.location = opt.sphere.allLocations{roi};
            sphere.radius = 10;
            
            specification = struct(...
                'sphere', sphere);
            
            % create simple spheres at the group coordinates
            mask = createRoi('sphere', sphere, betaImage, outputDir, opt.saveImg);


        end

    end
    
end