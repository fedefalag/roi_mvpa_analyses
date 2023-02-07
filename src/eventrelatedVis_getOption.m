function opt = eventrelatedVis_getOption()
    %   __  ____  ____     _      _    _
    %  / _)(  _ \(  _ \   | |    / \  | )
    % ( (_  )___/ )___/   | |_  / _ \ | \
    %  \__)(__)  (__)     |___||_/ \_||__)
    %
    % Thank you for using the CPP lap pipeline - version 0.0.3.
    %
    % Current list of contributors includes
    %  Mohamed Rezk
    %  Rémi Gau
    %  Olivier Collignon
    %  Ane Gurtubay
    %  Marco Barilari
    %
    % Please cite using the following DOI:
    %  https://doi.org/10.5281/zenodo.3554332
    %
    % For bug report, suggestions for improvements or contributions see our github repo:
    %  https://github.com/cpp-lln-lab/CPP_BIDS_SPM_pipeline

    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
    opt.groups = {''};
    % suject to run in each group
    %opt.subjects = {['002']}; %['002'],['004'],['005'],['006'],['007'],['008']

    % task to analyze
    opt.taskName = 'eventrelatedCombiemoVisual';
    
    % normalized space
    opt.space = 'MNI';
    % native space
    % opt.space = 'individual';
    
    % smoothing of data
    opt.funcFWHM = 2;

    % parallel pooling (I have max 2 workers on this computer)
    opt.parallelize.do = true;
    opt.parallelize.nbWorkers = 2;
    opt.parallelize.killOnExit = true;


    % The directory where the data are located
    opt.dataDir = '/Users/falagiarda/project-combiemo-playaround/exploring_the_repos/project-combiemo-bids/';
    opt.derivativesDir = '/Users/falagiarda/project-combiemo-playaround/exploring_the_repos/derivatives-visual/';
    opt.derivativesDataDir = '/Users/falagiarda/project-combiemo-playaround/exploring_the_repos/derivatives-visual/derivatives/cpp_spm/';
   
    % for MVPA with cosmo
    % directory of the masks
    % directory of my masks
    opt.locDir = '/Users/falagiarda/project-combiemo-playaround/only_localizers_analyses/derivatives-face/derivatives/cpp_spm/';
    % opt.maskDir = '/stats/ffx_task-facelocalizerCombiemo/ffx_space-MNI_FWHM-2/'; % sphereROIs masks are instead here: '/ROIs/resized/';
    opt.maskDir = strcat('/Users/falagiarda/project-combiemo-playaround/exploring_the_repos/derivatives-visual/derivatives/cpp_spm/cluster_masks_',num2str(opt.funcFWHM),'/label-expand/');
    
    opt.resDir = '/cosmoMVPA_res/funcROIs_res/'; % or /cosmoMVPA_res/funcROIs_res/
    opt.derivExtension = 'derivatives/cpp_spm/';
    opt.dataExtensionDir = '/stats/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-';


    % specify the model file that contains the contrasts to compute
    % univ
%    opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedAud_smdl.json';
    % multiv
    opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedVisMultivariate_smdl.json';
    opt.cosmomvpa.ffxResults = {'beta','t_maps'}; % 't_maps'
    % this is calculated for right and left TVAs with 6subj
    
    % opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
    opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
    
    %opt.cosmomvpa.ratioToKeepBetas = [187,132]; % min betas
    %opt.cosmomvpa.ratioToKeep = [200]; % min tmaps
    opt.cosmomvpa.nbTrialRepetition = 1; % each emotion repeated four times in each run
    opt.cosmomvpa.nbRun = 20; % there are 20 runs in total in the task
    opt.cosmomvpa.modalities = 'visual';
    opt.cosmomvpa.child_classifier=@cosmo_classify_libsvm;
    opt.cosmomvpa.feature_selector=@cosmo_anova_feature_selector;
    
    % subject number
    opt.subjects = {['008']};
    % feature selection
    opt.cosmomvpa.ratioToKeep = [100];
    


%     % feature selection 200 (masks have 350 or their max voxels)
%
%     % sub-002 
%     opt.cosmomvpa.rois = {'rSTS','lOFA','lSTS'}; % all three others are above 200 %
%     opt.voxNr = {'427','354','369'};
%     opt.thre = {'001unc','1unc','001unc'};
%
%     opt.cosmomvpa.rois = {'lFFA'}; % 'rFFA','rOFA','lFFA'
%     opt.voxNr = {'270'}; %'223','217','270' % 178, 106, 250 with unsmoothed data % 116, 193, 259 with 2mm smoothing
%     opt.thre = {'1unc'}; %,'1unc','1unc'
%
%     % all of them just in case you are using few enough features
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
%     opt.voxNr = {'223','217','427','270','354','369'};
%     opt.thre = {'1unc','1unc','001unc','1unc','1unc','001unc'};

%     % sub-004
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lSTS'}; % the last is above 200 %
%     opt.voxNr = {'447','387','362','423','401'};
%     opt.thre = {'01unc','01unc','001unc','1unc','001unc'};
%
%     opt.cosmomvpa.rois = {'lOFA'};
%     opt.voxNr = {'211'}; % 120 with unsmoothed data % 134 with 2mm smoothing
%     opt.thre = {'1unc'};
%
%     % all of them just in case you are using few enough features
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
%     opt.voxNr = {'447','387','362','423','211','401'};
%     opt.thre = {'01unc','01unc','001unc','1unc','1unc','001unc'};
     
%     % sub-005
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lSTS'}; % the last is below 200 % 
%     opt.voxNr =  {'391','423','421','424','388'};
%     opt.thre = {'01unc','01unc','001unc','01unc','001unc'};
%     
%     opt.cosmomvpa.rois = {'lOFA'};
%     opt.voxNr = {'190'}; % 112 with unsmoothed data % 129 with 2mm smoothing
%     opt.thre = {'1unc'};
%
%     % all of them just in case you are using few enough features
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
%     opt.voxNr =  {'391','423','421','424','190','388'};
%     opt.thre = {'01unc','01unc','001unc','01unc','1unc','001unc'};

%     % sub-006
%     opt.cosmomvpa.rois = {'rFFA','rSTS','lSTS'}; % all three others are above 200 %
%     opt.voxNr =  {'471','351','361'};
%     opt.thre = {'01unc','001unc','01unc'};
%     
%     opt.cosmomvpa.rois = {'lOFA'}; % 'rOFA','lFFA','lOFA' % all three others are above 200 %
%     opt.voxNr =  {'320'}; % '237','308','320' %% 97, 251, 158 with unsmoothed data % 123, 265, 191 with 2mm smoothing
%     opt.thre = {'1unc'};
%
%     % all of them just in case you are using few enough features
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
%     opt.voxNr =  {'471','237','351','308','320','361'};
%     opt.thre = {'01unc','1unc','001unc','1unc','1unc','01unc'};

%     % sub-007
%     opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
%     opt.voxNr = {'356','394','352','373','365','376'};
%     opt.thre = {'001unc','001unc','001unc','001unc','001unc','001unc'};

%     % sub-008
%     opt.cosmomvpa.rois = {'rFFA','rSTS','lFFA','lSTS'}; % the other two are below 200 %
%     opt.voxNr = {'391','404','351','393'};
%     opt.thre = {'01unc','001unc','001unc','001unc'};
%
%     opt.cosmomvpa.rois = {'lOFA'}; % 'rOFA','lOFA' % the other two are below 200 %
%     opt.voxNr = {'172'}; % '143','172' %% 92, 119 with unsmoothed data % 106, 134 with 2mm smoothing
%     opt.thre = {'1unc'};
% 
    % all of them just in case you are using few enough features
    opt.cosmomvpa.rois = {'rFFA','rOFA','rSTS','lFFA','lOFA','lSTS'};
    opt.voxNr =  {'391','143','404','351','172','393'};
    opt.thre = {'01unc','1unc','001unc','001unc','1unc','001unc'};

    
    
    
     

    % specify the result to compute
    % Contrasts.Name has to match one of the contrast defined in the model json file
    opt.result.Steps(1) = struct( ...
        'Level',  'dataset', ...
        'Contrasts', struct( ...
                        'Name', '', ... %
                        'Mask', false, ... % this might need improving if a mask is required
                        'MC', 'FWE', ... FWE, none, FDR
                        'p', 0.05, ...
                        'k', 0, ...
                        'NIDM', true));

    % Options for slice time correction
    % If left unspecified the slice timing will be done using the mid-volume acquisition
    % time point as reference.
    % Slice order must be entered in time unit (ms) (this is the BIDS way of doing things)
    % instead of the slice index of the reference slice (the "SPM" way of doing things).
    % More info here: https://en.wikibooks.org/wiki/SPM/Slice_Timing
    opt.sliceOrder = [0,		0.9051,		0.0603,		0.9655,		0.1206,		1.0258,		0.181,		1.0862,		0.2413,		1.1465,		0.3017,		1.2069,		0.362,		1.2672,		0.4224,		1.3275,		0.4827,		1.3879,		0.5431,		1.4482,		0.6034,		1.5086,		0.6638,		1.5689,		0.7241,		1.6293,		0.7844,		1.6896,		0.8448,		0,		0.9051,		0.0603,		0.9655,		0.1206,		1.0258,		0.181,		1.0862,		0.2413,		1.1465,		0.3017,		1.2069,		0.362,		1.2672,		0.4224,		1.3275,		0.4827,		1.3879,		0.5431,		1.4482,		0.6034,		1.5086,		0.6638,		1.5689,		0.7241,		1.6293,		0.7844,		1.6896,		0.8448	];
    opt.STC_referenceSlice = [0.8448];

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [2.6 2.6 2.6];

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile( ...
        opt.dataDir, '..', 'derivatives', ...
        'SPM12_CPPL', 'JOBS', opt.taskName);

    % Save the opt variable as a mat file to load directly in the preprocessing
    % scripts
    save('opt.mat', 'opt');

end