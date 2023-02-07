function opt = designtwo_getOption_overlap

opt.groups = {['one']}; 

% subjects list
opt.subjects = {['001']}; % ['001'],['002'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['021'],
%opt.subjects = {['001'],['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']}; % just as reference

opt.sphere.radius = 20;
opt.sphere.allLocations = {[55,-23,-5],[-60,-30,0]}; %[50,0,55],[-45,0,52],
opt.rois = {['rMTG'],['lMTG']}; % ['rPreCG'],['lPreCG'], % names taken from bspmview: preCentral gyrus and Middle Temporal gyrus %

% opt.sphere.radius = 4; % starting radius for 'expand'
% opt.sphere.maxNbVoxels = 300;

% Smoothing level of localizer and data respectively
opt.locFWHM = 6;
opt.eventFWHM = 2;
 
%opt.locPath = '/Users/falagiarda/project-combiemo-playaround/only_localizers_analyses/derivatives-face/derivatives/cpp_spm/';
%opt.maskPath = '/stats/ffx_task-facelocalizerCombiemo/ffx_space-MNI_FWHM-';

opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/localizers_overlap';

opt.dataPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';
opt.betaPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/sub-001/stats/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-2/beta_0001.nii';
opt.betaForSphere = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/beta0001.nii';

opt.saveImg = 1;

end