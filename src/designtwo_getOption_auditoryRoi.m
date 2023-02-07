function opt = designtwo_getOption_auditoryRoi(nrVoxels)

opt.groups = {['one']}; 

opt.subjects = {['001']}; % just as reference for the beta

% group coordinates for peak of left and right TVAs and MFSs
opt.sphere.allLocations = {[55 -24 0],[-62 -24 0],[55 0 47],[-52 -11 52]};
opt.rois = {'rTVA','lTVA','rMFS','lMFS'};

% 
opt.sphere.radius = 4; % starting radius
opt.sphere.maxNbVoxels = nrVoxels;

% smoothing mm
opt.eventFWHM = 2;
 
% binary mask from group level voice localizer
opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/rfx_task-voicelocalizerCombiemo/ffx_FWHM-6/rfx_space-MNI_FWHM-8/';
opt.maskName = 'taskvoicelocalizerCombiemovoicesgtobjectsn23';

% % neurosynth masks
% opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/neurosynth_masks_aud/';
% opt.maskName = 'voicelTVAassociationatestbinary'; % 'voicerTVAassociationatestbinary'

opt.dataPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';
opt.betaPath = '/stats/ffx_task-eventrelatedCombiemoAuditory/ffx_space-MNI_FWHM-';

opt.saveImg = 1;

end