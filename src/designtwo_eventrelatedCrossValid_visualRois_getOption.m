function opt = designtwo_eventrelatedCrossValid_visualRois_getOption()
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

    % tasks to analyze in visual ROIs
    opt.tasks = {'eventrelatedCombiemoVisual','eventrelatedCombiemoAuditory','eventrelatedCombiemoBimodal'};
    opt.taskName = 'eventrelatedCombiemoAuditory';
    
    % group of subjects to analyze
    opt.groups = {''};
    % Smoothing level of used data
    opt.funcFWHM = 2;
    
    % All subjects
    %['001'],['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']
    
%     % 18 runs
     
opt.subjectsVisual = {['001'],['002'],['003'],['004'],['005'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['022'],['023'],['024']};
opt.subjectsAuditory = {['001'],['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['012'],['013'],['015'],['016'],['017'],['018'],['019'],['020'],['022'],['023'],['024']};
opt.subjectsBimodal = {['001'],['002'],['003'],['004'],['005'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['022'],['023'],['024']};
  
%     
%     % 19 runs
     opt.subjectsVisual = {['006'],['021']};
%     opt.subjectsAuditory = {['014'],['021']};
%     opt.subjectsBimodal = {['006'],['021']};
%     % 20 runs
%   opt.subjectsAuditory = {['011']};
    
    

    
    % normalized space
    opt.space = 'MNI';
    
%    % native space
%    opt.space = 'individual';

% parallel pooling (I have max 2 workers on this computer)
opt.parallelize.do = true;
opt.parallelize.nbWorkers = 2;
opt.parallelize.killOnExit = true;


% The directory where the data are located
opt.dataDir = '/Users/falagiarda/project-combiemo-playaround/design-two/raw';
opt.derivativesDir = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives';
opt.derivativesDataDir = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';

% for MVPA with cosmo
% directory of the masks
% directory of my masks
opt.masksPath = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/';
%opt.maskNames = {'label-sphere10_rFFA_facelocalizerCombiemogroup22mask','label-sphere10_rOFA_facelocalizerCombiemogroup22mask','label-sphere10_lOFA_facelocalizerCombiemogroup22mask','label-expandVox183_rpSTS_facelocalizerCombiemogroup22mask','label-expandVox179_lpSTS_facelocalizerCombiemogroup22mask'};



% MVPA results directory
opt.resDir = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/';
opt.modResDir = {['visual/'],['auditory/'],['bimodal/']};

% opt.derivExtension = 'derivatives/cpp_spm/';
% stats directory within subject specific folder
opt.dataExtensionDir = '/stats/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-';
%opt.funcFWHM = 2;

% specify the model file that contains the contrasts to compute
% univ
%    opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedAud_smdl.json';
% multiv
opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedVisMultivariate_smdl.json';


% All info needed to CosmoMVPA
opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.cosmomvpa.ffxResults = {'beta'}; %

opt.cosmomvpa.normalization = 'zscore';
opt.cosmomvpa.ratioToKeep = [100]; % n of voxels for feature selection
opt.cosmomvpa.nbTrialRepetition = 1; % each emotion repeated four times in each run ang gives 4 betas
opt.cosmomvpa.nbRun = 19; % there are 18 runs in total in the task but some subjects have 19 or 20 %
opt.cosmomvpa.modalities = 'visual';
opt.cosmomvpa.child_classifier=@cosmo_classify_libsvm;
opt.cosmomvpa.feature_selector=@cosmo_anova_feature_selector;
     

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
