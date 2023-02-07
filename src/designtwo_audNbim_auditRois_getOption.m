function opt = designtwo_audNbim_auditRois_getOption()
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
    
    % all subjects
    opt.allSubjects = [1:24];
    
    % 18 runs
     opt.subjectsVisual = {['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']};
     opt.subjectsAuditory = {['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']};
     opt.subjectsBimodal = {['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']};
     
     opt.subjectsVisual = {['002'],['003']};
     opt.subjectsAuditory = {['002'],['003']};
     opt.subjectsBimodal = {['002'],['003']};
     
%      % 19 runs
%      opt.subjectsVisual = {['006'],['021']};
%      opt.subjectsAuditory = {['014']};
%      opt.subjectsBimodal = {['006'],['021']};
     
% parallel pooling (I have max 2 workers on this computer)
opt.parallelize.do = true;
opt.parallelize.nbWorkers = 2;
opt.parallelize.killOnExit = true;

% The directory where the data are located
opt.dataDir = '/Users/falagiarda/project-combiemo-playaround/design-two/raw';
opt.derivativesDir = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives';
opt.derivativesDataDir = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';

% Where the models are located
opt.modelsDir = '/Users/falagiarda/project-combiemo-playaround/design-two/rsa-models/';
opt.modelsTypes = {'emotion','valence','arousal'}; %'emotion','valence','arousal'
opt.stimRatingModality = {'Visual','Auditory'};

% for MVPA with cosmo
% directory of the masks
% directory of my masks
opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/';
opt.moreMaskPath = '/task-voicelocalizerCombiemo/all_masks_for_mvpa/';

opt.decodingsPath = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/MVPA_by_stimulus/aud-rois/';

% MVPA results directory
opt.resDir = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/MVPA_best-mod_vs_multim/aud-rois';
opt.modResDir = {['visual/'],['auditory/'],['bimodal/']};

%    opt.derivExtension = 'derivatives/cpp_spm/';
% stats directory within subject specific folder
opt.dataExtensionDir = '/stats-previous/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-';
opt.funcFWHM = 2;

% specify the model file that contains the contrasts to compute
% univ
%    opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedAud_smdl.json';
% multiv
opt.model.file = '/Users/falagiarda/GitHub/combiemo_fMRI_analyses/src/model-eventrelatedVisMultivariate_smdl.json';


% All info needed to CosmoMVPA
opt.rois = {'rTVA','lTVA','rMFS','lMFS'};
%opt.rois = {'rTVA','lTVA'};
opt.ffxResults = {'beta'}; % 't_maps'

%opt.cosmomvpa.normalization = 'zscore';
opt.cosmomvpa.ratioToKeep = [100]; % n of voxels for feature selection
opt.cosmomvpa.feature_selection_ratio_to_keep = [100];
opt.cosmomvpa.ffxResults = ['beta'];
opt.cosmomvpa.nbTrialRepetition = 1; % each emotion repeated four times in each run
opt.cosmomvpa.nbVisualRun = 18;
opt.cosmomvpa.nbAuditoryRun = 18;
opt.cosmomvpa.nbBimodalRun = 18;% there are 18 runs in total in the task but some subjects have 19 or 20 %
opt.cosmomvpa.modalities = 'auditory';
opt.cosmomvpa.child_classifier=@cosmo_classify_libsvm;
opt.cosmomvpa.feature_selector=@cosmo_anova_feature_selector;
     
end
