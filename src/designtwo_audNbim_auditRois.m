% get options for this script
opt = designtwo_audNbim_auditRois_getOption;
cosmo_warning('once')

individual=1;
average=0;

RDMoutputs = struct;
averageRDM = struct;

subjects = 1:24;
nr_regr = 5;

permute = 1;

% set structure array for keeping the results
accu = struct( ...
    'sub', [], ...
    'roiArea', [], ...
    'roiNbVoxels', [], ...
    'ffxResults', [], ...
    'conditions', [], ...
    'accuracy', []);
%'predictors', []
allsubjects = [1,2,3,4,5,106,7,8,9,10,111,12,13,114,15,16,17,18,19,20,21,22,23,24];

for iRoi = 1:length(opt.rois)
    
    %Select nr subjects based on roi
    if strcmp(opt.rois{iRoi},'rMFS')
        subjects = allsubjects;
        subjects(ismember(subjects,[1,4,106,21,24])) = [];
        
    elseif strcmp(opt.rois{iRoi},'lMFS')
        subjects = allsubjects;
        subjects(ismember(subjects,[1,4,106,18,21,24])) = [];
        
    elseif strcmp(opt.rois{iRoi},'rTVA')
        subjects = allsubjects;
    elseif strcmp(opt.rois{iRoi},'lTVA')
        subjects = allsubjects;
    end
    
    for iSub = 1:length(subjects)
        
        currentSubj = strcat('sub-',num2str(subjects(iSub),'%03.f'));
        
        % nb runs changes in a few cases
        if strcmp(currentSubj,'sub-006') % turn to subj 106 (modelize
            %opt.cosmomvpa.nbVisualRun = 19;
            opt.cosmomvpa.nbAuditoryRun = 18;
            opt.cosmomvpa.nbBimodalRun = 19;
        elseif strcmp(currentSubj,'sub-014') % turn to sub 114
            %opt.cosmomvpa.nbVisualRun = 18;
            opt.cosmomvpa.nbAuditoryRun = 19;
            opt.cosmomvpa.nbBimodalRun = 18;
        elseif strcmp(currentSubj,'sub-021') % should be ok cos both mod have 19runs%
            %opt.cosmomvpa.nbVisualRun = 19;
            opt.cosmomvpa.nbAuditoryRun = 19;
            opt.cosmomvpa.nbBimodalRun = 19;
        elseif strcmp(currentSubj,'sub-011') % turn to subj 111
            %opt.cosmomvpa.nbVisualRun = 18;
            opt.cosmomvpa.nbAuditoryRun = 20;
            opt.cosmomvpa.nbBimodalRun = 18;
        else
            %opt.cosmomvpa.nbVisualRun = 18;
            opt.cosmomvpa.nbAuditoryRun = 18;
            opt.cosmomvpa.nbBimodalRun = 18;
        end
        
        for iffxRes = 1:length(opt.ffxResults)
            
            % Trying to classify - within-modal MVPA style, aud vs bimodal
            
            data_fn_aud = strcat(opt.derivativesDataDir,currentSubj,'/stats-previous/ffx_task-',opt.tasks{2},'/ffx_space-MNI_FWHM-',num2str(opt.funcFWHM),'/4D_',opt.ffxResults{iffxRes},'_',num2str(opt.funcFWHM),'.nii');
            data_fn_bim = strcat(opt.derivativesDataDir,currentSubj,'/stats-previous/ffx_task-',opt.tasks{3},'/ffx_space-MNI_FWHM-',num2str(opt.funcFWHM),'/4D_',opt.ffxResults{iffxRes},'_',num2str(opt.funcFWHM),'.nii');
            
            mask_fn = strcat(opt.maskPath,currentSubj,opt.moreMaskPath,'sub',num2str(subjects(iSub),'%03.f'),opt.rois{iRoi},'mask.nii');
            %aud targets
            targets_aud=repelem([1:5],opt.cosmomvpa.nbAuditoryRun)';
            % read auditory ds
            ds_aud = cosmo_fmri_dataset(data_fn_aud, ...
                'mask',mask_fn,...
                'targets',targets_aud);
            
            % create chunks for crossvalidation
            chunks_aud = repmat((1:opt.cosmomvpa.nbAuditoryRun)', 1, opt.cosmomvpa.nbTrialRepetition)';
            chunks_aud = chunks_aud(:);
            chunks_aud = repmat(chunks_aud, nr_regr, 1);
            % create labels
            labels_aud = repelem({'ne_aud','di_aud','fe_aud','ha_aud','sa_aud'},opt.cosmomvpa.nbAuditoryRun)';
            
            
            % bim targets and data
            targets_bim=repelem([6:10],opt.cosmomvpa.nbBimodalRun)';
            % read bimodal ds
            ds_bim = cosmo_fmri_dataset(data_fn_bim, ...
                'mask',mask_fn,...
                'targets',targets_bim);
            
            % create chunks for crossvalidation
            chunks_bim = repmat((1:opt.cosmomvpa.nbBimodalRun)', 1, opt.cosmomvpa.nbTrialRepetition)';
            chunks_bim = chunks_bim(:);
            chunks_bim = repmat(chunks_bim, nr_regr, 1);
%             % as these are considered as different runs, make sure the numbers are different!! (add nr of unimodal runs)%
%             chunks_bim = chunks_bim + opt.cosmomvpa.nbAuditoryRun;
            
            % create_labels
            labels_bim = repelem({'ne_bim','di_bim','fe_bim','ha_bim','sa_bim'},opt.cosmomvpa.nbBimodalRun)';
            
            
            % Set up the pairs you want the classifier to learn to distinguish %
            conditionsToTest = {'1-6','2-7','3-8','4-9','5-10'};
            
            count = 1;
            
            for iConditionToTest = 1:length(conditionsToTest)
                
                % stack the two modalities together
                ds = cosmo_stack({ds_aud,ds_bim},1,'unique');
                % combine labels
                ds.sa.labels = [labels_aud;labels_bim];
                ds.sa.chunks = [chunks_aud;chunks_bim];
                
                % remove NaNs etc
                ds = cosmo_remove_useless_data(ds);
                % cosmo check
                cosmo_check_dataset(ds);
                
                % getting rid off zeros
                zero_msk = all(ds.samples == 0, 1);
                
                ds = cosmo_slice(ds, ~zero_msk, 2);
                
                mask_size = size(ds.samples, 2);
                
                
                % if statements with the slicing of the data based on the targets needed%
                if strcmp(conditionsToTest{iConditionToTest}, '1-6')
                    ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 6);
                elseif strcmp(conditionsToTest{iConditionToTest}, '2-7')
                    ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 7);
                elseif strcmp(conditionsToTest{iConditionToTest}, '3-8')
                    ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 8);
                elseif strcmp(conditionsToTest{iConditionToTest}, '4-9')
                    ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 9);
                elseif strcmp(conditionsToTest{iConditionToTest}, '5-10')
                    ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 10);
                end
                
                
                % partitioning, for test and training : cross validation
                partitions = cosmo_nfold_partitioner(ds);
                
                % ROI mvpa analysis
                [~, accuracy] = cosmo_crossvalidate(ds, ...
                    @cosmo_meta_feature_selection_classifier, ...
                    partitions, opt.cosmomvpa);
                
                                %% PERMUTATION PART
                if permute
                    [acc0] = permuteAccuracy(ds,accuracy, partitions, opt);
                    accu(count).permutation = acc0';
                end
                
                % store results to be saved
                accu = storeResults(accu, count, ...
                    currentSubj, ...
                    opt.rois(iRoi), ...
                    mask_size, ...
                    opt.cosmomvpa.ffxResults, ...
                    conditionsToTest{iConditionToTest}, ...
                    accuracy);
                
                count = count + 1;
                
                fprintf([currentSubj '  - condition: ' opt.rois{iRoi} ', accuracy: ' num2str(accuracy) '\n\n\n']);
                
            end
            
        end
        
        
        % set output results dir
        pathOutput = opt.resDir;
        
        %set names output file
        savefileMat = fullfile(pathOutput, ...
            [opt.rois{iRoi},...
            'sub-', currentSubj, ...
            '_task-', opt.taskName, ...
            '_cosmomvpa_FWHM-', num2str(opt.funcFWHM), ...
            '_', datestr(now, 'yyyymmdd'), '.mat' ]);
        
        savefileCsv = fullfile(pathOutput, ...
            [opt.rois{iRoi},...
            'sub-', currentSubj, ...
            '_task-', opt.taskName, ...
            '_cosmomvpa_FWHM-', num2str(opt.funcFWHM), ...
            '_', datestr(now, 'yyyymmdd'), '.csv' ]);
        
        save(savefileMat, 'accu');
        
        writetable(struct2table(accu), savefileCsv)
        
    end
    
end

function  accu = storeResults(accu, count, subID, roiName, ...
    mask_size, ffxResult, conditionName, accuracy, ~)

% store results
accu(count).sub = subID;
accu(count).roiArea = roiName;
accu(count).roiNbVoxels = mask_size;
accu(count).ffxResults = ffxResult;
accu(count).conditions = conditionName;
accu(count).accuracy = accuracy;
%accu(count).predictors = pred;

end

function [acc0] = permuteAccuracy(ds,accuracy, partitions, opt)                

%number of iterations
niter = 100;

% allocate space for permuted accuracies
acc0 = zeros(niter,1); 

 % make a copy of the dataset
ds0 = ds;

%for niter iterations, reshuffle the labels and compute accuracy
% Use the helper function cosmo_randomize_targets
for k=1:niter
    
    ds0.sa.targets=cosmo_randomize_targets(ds);
    [~, acc0(k)]=cosmo_crossvalidate(ds0, @cosmo_classify_meta_feature_selection,...
        partitions,opt.cosmomvpa);
end

p = sum(accuracy<acc0)/niter;
%fprintf('%d permutations: accuracy=%.3f, p=%.4f\n', niter, accuracy, p);
                 
end