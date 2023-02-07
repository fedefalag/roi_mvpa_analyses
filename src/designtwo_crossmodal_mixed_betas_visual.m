% cosmo MVPA
% first run  opt = designtwo_crossmodal_mixed_betas_getOption();

function designtwo_crossmodal_mixed_betas_visual(opt, funcFWHM)

% be very verbose please
cosmo_warning('off')

% Loop through groups and subjects

for iTask = 2:2%length(opt.tasks) % testing on one beta 

test = 1; % make sure 1 = test on one beta

    % Select task name : taks/data that is currently being used for the classification %
    opt.taskName = opt.tasks{iTask};    

    if iTask == 1
        opt.subjects = opt.subjectsVisual;
    elseif iTask == 2
        opt.subjects = opt.subjectsAuditory;
    elseif iTask == 3
        opt.subjects = opt.subjectsBimodal;
    end
    
    %test=3;
    %opt.taskName = opt.tasks{iTask};
    
    %[~, opt] = getData(opt);

%for iSub = 1:group(iGroup).numSub
for iSub = 1:length(opt.subjects)
    
    
% Rois are the following
    opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
    % except in a few cases in which not all 8 ROIs could be indentified %
    if opt.subjects{iSub} == '003'
        opt.cosmomvpa.rois = {'lFFA','rOFA','rpSTS','lpSTS','rMFS','lMFS'}; %,'lOFA'
    elseif opt.subjects{iSub} == '001' % just provisionally left out lMFS
        opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS'};
    elseif opt.subjects{iSub} == '004'
        opt.cosmomvpa.rois = {'rFFA','lFFA','lOFA','rpSTS','lpSTS','rMFS'}; % ,'rOFA'
%     elseif opt.subjects{iSub} == '010' % just provisionally left out lOFA
%         opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','rpSTS','lpSTS','rMFS','lMFS'};
    elseif opt.subjects{iSub} == '011'
        opt.cosmomvpa.rois = {'rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
    elseif opt.subjects{iSub} == '012'
        opt.cosmomvpa.rois = {'rFFA','rOFA','lOFA','rpSTS','lpSTS'}; 
%     elseif opt.subjects{iSub} == '014' % just provisionally left out lOFA
%         opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','rpSTS','lpSTS','rMFS','lMFS'};
    elseif opt.subjects{iSub} == '015'
         opt.cosmomvpa.rois = {'lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
%     elseif opt.subjects{iSub} == '016' % just provisionally left out lOFA
%         opt.cosmomvpa.rois = {'rFFA','lFFA','rOFA','rpSTS','lpSTS','rMFS','lMFS'};
    elseif opt.subjects{iSub} == '019'
        opt.cosmomvpa.rois = {'rFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
    elseif opt.subjects{iSub} == '020'
        opt.cosmomvpa.rois = {'rFFA','lFFA','rpSTS','lpSTS','rMFS','lMFS'}; 
    elseif opt.subjects{iSub} == '021'
        opt.cosmomvpa.rois = {'rFFA','lFFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
     elseif opt.subjects{iSub} == '022'
         opt.cosmomvpa.rois = {'rFFA','lFFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % rOFA
    elseif opt.subjects{iSub} == '024'
        opt.cosmomvpa.rois = {'lFFA','lOFA','lpSTS','lMFS'};
    end
                
        % set structure array for keeping the results
        accu = struct( ...
            'sub', [], ...
            'group', [], ...
            'roiArea', [], ...
            'roiDimension', [], ...
            'roiNbVoxels', [], ...
            'ffxResults', [], ...
            'conditions', [], ...
            'modality', [], ...
            'accuracy', []);
          % 'predictors', []);
        
        % get FFX path
        subID = opt.subjects{iSub};
        groupName = 'withinSubj';
        
        pathDataModOne = strcat(opt.derivativesDataDir,'sub-',subID,'/stats-mvpa/ffx_task-',opt.tasks{iTask},'/ffx_space-MNI_FWHM-',num2str(funcFWHM),'/');
        pathDataModMlt = strcat(opt.derivativesDataDir,'sub-',subID,'/stats/ffx_task-',opt.tasks{iTask},'/ffx_space-MNI_FWHM-',num2str(funcFWHM),'/');
        
        fprintf(['\n For subj: ' subID '\n\n for task:' opt.tasks{iTask}]);
        
        % loop through ffxResults (betas only atm)
        
        count = 1;
        
        for iFfxResult = 1:length(opt.cosmomvpa.ffxResults)
            
            %fprintf(['\n For ffx result: ' opt.cosmomvpa.ffxResults{iFfxResult} '\n\n']);
            
            % set the 4D result image for Visual and Auditory data
            resultsImageModOne = fullfile(pathDataModOne,['4D_' opt.cosmomvpa.ffxResults{iFfxResult} '_' num2str(funcFWHM) '.nii']);
            resultsImageModMlt = fullfile(pathDataModMlt,['4D_' opt.cosmomvpa.ffxResults{iFfxResult} '_' num2str(funcFWHM) '.nii']);
            
            % loop through ROI dimension and area
            
            for iRoi = 1:length(opt.cosmomvpa.rois)
                
%                 % set ratio to keep depending on the ROI and 4D map
%                 if strcmp(opt.cosmomvpa.ffxResults{iFfxResult}, 'beta')
%                  opt.cosmomvpa.ratioToKeep = opt.cosmomvpa.ratioToKeepBetas;
%                 elseif strcmp(opt.cosmomvpa.ffxResults{iFfxResult}, 't_maps')
%                  opt.cosmomvpa.ratioToKeep = opt.cosmomvpa.ratioToKeepTmaps;
%                 end
                
                opt.cosmomvpa.feature_selection_ratio_to_keep = opt.cosmomvpa.ratioToKeep;
                
                % load ROI masks for a specific dimension
                roiPattern = fullfile(strcat(opt.masksPath,'sub-',opt.subjects{iSub},opt.moreMasksPath,'sub',opt.subjects{iSub},opt.cosmomvpa.rois{iRoi},'mask.nii'));
                
                roiFileNames = dir(roiPattern);
                
                for i = 1:length(roiFileNames)
                    
                    roiMasks{i} = roiFileNames(i).name;  %#ok<*AGROW>
                    
                end
                
                %% ROI MVPA analyses
                
                for iMask = 1:length(roiMasks)
                    
                    % define brain mask
                    mask = roiPattern;
                    
                    roiName = regexp(roiMasks{iMask}, '_', 'split');
                    
                    %fprintf(['\nMask: ' roiName{1} '\n\n']);
                    
                    %% 5 emotions
                    
                    % stim and labels for the 4D maps with one beta per condition %
                    stim_one = [1 2 3 4 5]; % neutral, disgust, fear, happiness, sadness                    
                    labels_one = {'1','2','3','4','5'};
                    
                    % stim and labels for the 4D maps with one beta per event (multiple betas per condition) %
                    stim_mlt = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5]; % neutral, disgust, fear, happiness, sadness                    
                    labels_mlt = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'};
                    
                    %conditionsToTest = {'fiveClassDecoding'};
                    
                        conditionsToTest = {'fiveClassDecoding',...
                        'Ne-Di','Ne-Fe','Ne-Ha','Ne-Sa',...
                        'Di-Fe','Di-Ha','Di-Sa',...
                        'Fe-Ha','Fe-Sa',...
                        'Ha-Sa'};
                    
                    for iConditionToTest = 1:length(conditionsToTest)
                                                
                            %% define the data structure with the visual data %
                            ds_one = cosmo_fmri_dataset(resultsImageModOne, 'mask', mask);
                            
                            % getting rid off zeros
                            zero_msk = all(ds_one.samples == 0, 1);
                            
                            ds_one = cosmo_slice(ds_one, ~zero_msk, 2);
                            
                            %mask_size_vis = size(ds_vis.samples, 2);
                            
                            % set chunks, targets and labels                            
                            ds_one = setTargetsChunksLabels(opt, ds_one, stim_one, labels_one, [1]);
                            
                            
                            %% define the data structure with the auditory data %
                            ds_mlt = cosmo_fmri_dataset(resultsImageModMlt, 'mask', mask);
                            
                            % getting rid off zeros
                            zero_msk = all(ds_mlt.samples == 0, 1);
                            
                            ds_mlt = cosmo_slice(ds_mlt, ~zero_msk, 2);
                            
                            %mask_size_aud = size(ds_aud.samples, 2);
                            
                            % set chunks, targets and labels                            
                            ds_mlt = setTargetsChunksLabels(opt, ds_mlt, stim_mlt, labels_mlt, [2]);
                            
                            
                            %% Combine the two datasets
                                    
                            ds = cosmo_stack({ds_one,ds_mlt},1,'unique');
                            
                            mask_size = size(ds.samples, 2);                            
                            
                                            
                                    % 5 emotions - five class decoding
                                    if strcmp(conditionsToTest{iConditionToTest}, 'fiveClassDecoding')
                                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 2 | ds.sa.targets == 3 | ds.sa.targets == 4 | ds.sa.targets == 5);
                                    % all pairs of emotions - binary decoding %
                                        % neutral vs disgust
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Ne-Di')
                                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 2);
                                        % neutral vs fear
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Ne-Fe')
                                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 3);
                                        % neutral vs joy
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Ne-Ha')
                                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 4);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Ne-Sa')
                                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 5);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Di-Fe')
                                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 3);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Di-Ha')
                                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 4);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Di-Sa')
                                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 5);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Fe-Ha')
                                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 4);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Fe-Sa')
                                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 5);
                                        
                                    elseif strcmp(conditionsToTest{iConditionToTest}, 'Ha-Sa')
                                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 5);
                                    end
                                    
                            
                            % remove constant features
                            ds = cosmo_remove_useless_data(ds);
                            
%                             % partitioning, for test and training : cross validation
%                             partitions = cosmo_nfold_partitioner(ds);        
                            
                            %% Feature Selection - to set up across model specifications
                            partitions=cosmo_nchoosek_partitioner(ds, 1,'modality',test);
                                                       
                            % ROI mvpa analysis
                            [~, accuracy] = cosmo_crossvalidate(ds, ...
                                @cosmo_meta_feature_selection_classifier, ...
                                partitions, opt.cosmomvpa);
                            
                            % store results to be saved
                            accu = storeResults(accu, count, ...
                                subID, ...
                                groupName, ...
                                roiName{1}, ...
                                opt.cosmomvpa.rois(iRoi), ...
                                mask_size, ...
                                opt.cosmomvpa.ffxResults{iFfxResult}, ...
                                conditionsToTest{iConditionToTest}, ...
                                opt.cosmomvpa.modalities, ...
                                accuracy);
                            
                            count = count + 1;
                            
                            %fprintf(['  - condition: ' conditionsToTest{iConditionToTest} ', accuracy: ' num2str(accuracy) '\n\n\n']);
                            
                        %end
                        
                    end
                    

                    
                end
                
            end
            
        end
        
        % set output results dir
        pathOutput = strcat(opt.resDir,opt.modResDir{iTask});
        
%         %set names output file 
%         savefileMat = fullfile(pathOutput, ...
%             ['sub-', subID, ...
%             '_task-', opt.cosmomvpa.modalities, ...
%             '_cosmomvpa_FWHM-', num2str(funcFWHM), ...
%             '_', datestr(now, 'yyyymmdd'), '.mat' ]);
        
        savefileCsv = fullfile(pathOutput, ...
            ['sub-', subID, ...
            '_task-', opt.tasks{iTask}, ...
            '_cosmomvpa_FWHM-', num2str(funcFWHM), ...
            '_', datestr(now, 'yyyymmdd'), ...
            '_', num2str(test),'.csv' ]);        
        
%       save(savefileMat, 'accu');
        
        writetable(struct2table(accu), savefileCsv)
        
end
end
    
end

function ds = setTargetsChunksLabels(opt, ds, stim, labels, mod)

% set chunks (runs by trial_type), target (stimulation type - modality),
% names (stimulation type name)
trialsPerRun = length(stim) * opt.cosmomvpa.nbTrialRepetition;

chunks = repmat((1:opt.cosmomvpa.nbRun)', 1, opt.cosmomvpa.nbTrialRepetition)';
chunks = chunks(:);
chunks = repmat(chunks, trialsPerRun, 1);

targets = repmat(stim', 1, opt.cosmomvpa.nbRun)';
targets = targets(:);

labels = repmat(labels', 1, opt.cosmomvpa.nbRun)';
labels = labels(:);

modal = repmat(repmat(mod,1,length(stim)), 1, opt.cosmomvpa.nbRun)';
modal = modal(:) ;

ds.sa.targets = targets;
ds.sa.chunks = chunks;
ds.sa.labels = labels;
ds.sa.modality = modal;

end


function  accu = storeResults(accu, count, subID, groupName, roiName, ...
    roiDimension, mask_size, ffxResult, conditionName, modality, accuracy, ~)

% store results
accu(count).sub = subID;
accu(count).group = groupName;
accu(count).roiArea = roiName;
accu(count).roiDimension = roiDimension;
accu(count).roiNbVoxels = mask_size;
accu(count).ffxResults = ffxResult;
accu(count).conditions = conditionName;
accu(count).modality = modality;
accu(count).accuracy = accuracy;
%accu(count).predictors = pred;

end