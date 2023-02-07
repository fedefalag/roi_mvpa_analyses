function opt = designtwo_getOption_visualRoi(nrVoxels)

opt.groups = {['one']}; 

opt.subjects = {['001']}; % just as reference

% ROIs
% opt.rois = {'rpSTS','lpSTS'}; % cluster shape
 opt.rois = {'rFFA','rOFA','lOFA'}; % sphere

% % group coordinates

% % STSs
% opt.sphere.allLocations = {[55 -37 5],[-65 -47 13]}; 
% FFA and OFAs
opt.sphere.allLocations = {[44 -44 -26],[47 -81 -13], [-42 -89 -13]}; 

opt.sphere.radius = 4; % starting radius
opt.sphere.maxNbVoxels = nrVoxels;

opt.locFWHM = 6;
opt.eventFWHM = 2;
 
%opt.locPath = '/Users/falagiarda/project-combiemo-playaround/only_localizers_analyses/derivatives-face/derivatives/cpp_spm/';
%opt.maskPath = '/stats/ffx_task-facelocalizerCombiemo/ffx_space-MNI_FWHM-';

opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/rfx_task-facelocalizerCombiemo/ffx_FWHM-6/rfx_space-MNI_FWHM-8/';

opt.maskName = 'facelocalizerCombiemogroup22mask';

opt.dataPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';
opt.betaPath = '/stats/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-';

opt.saveImg = 1;

end