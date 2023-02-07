% cosmo MVPA
% first run  opt = designtwo_crossmodal_individual_masks_getOption();

function designtwo_crossmodal_individual_masks_visual(opt, funcFWHM)

% be very verbose please
cosmo_warning('off')

% Loop through groups and subjects

for iModality = 1:2 % Visual as test, auditory as test, and the average(both)

                if iModality==3
                    test=[];
                else
                    test = iModality;
                end
    
    %test=3;
    %opt.taskName = opt.tasks{iTask};
    
    %[~, opt] = getData(opt);

%for iSub = 1:group(iGroup).numSub
for iSub = 1:length(opt.subjects)
    
    
    % Rois are the following
    opt.cosmomvpa.rois = {'rpSTS','lpSTS','rMFS','lMFS'};
    % except in a few cases in which not all ROIs coudl be indentified %
    if opt.subjects{iSub} == '001'
        opt.cosmomvpa.rois = {'rpSTS','lpSTS','rMFS'}; 
    elseif opt.subjects{iSub} == '004'
        opt.cosmomvpa.rois = {'rpSTS','lpSTS','rMFS'}; 
    elseif opt.subjects{iSub} == '012'
        opt.cosmomvpa.rois = {'rpSTS','lpSTS'}; 
    elseif opt.subjects{iSub} == '024'
        opt.cosmomvpa.rois = {'lpSTS','lMFS'};
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
        
        pathDataVis = strcat(opt.derivativesDataDir,'sub-',subID,'/stats-mvpa/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-',num2str(funcFWHM),'/');
        pathDataAud = strcat(opt.derivativesDataDir,'sub-',subID,'/stats-mvpa/ffx_task-eventrelatedCombiemoAuditory/ffx_space-MNI_FWHM-',num2str(funcFWHM),'/');
        
        fprintf(['\n For subj: ' subID '\n\n']);
        
        % loop through ffxResults (beta and tmaps)
        
        count = 1;
        
        for iFfxResult = 1:length(opt.cosmomvpa.ffxResults)
            
            fprintf(['\n For ffx result: ' opt.cosmomvpa.ffxResults{iFfxResult} '\n\n']);
            
            % set the 4D result image for Visual and Auditory data
            resultsImageVis = fullfile(pathDataVis,['4D_' opt.cosmomvpa.ffxResults{iFfxResult} '_' num2str(funcFWHM) '.nii']);
            resultsImageAud = fullfile(pathDataAud,['4D_' opt.cosmomvpa.ffxResults{iFfxResult} '_' num2str(funcFWHM) '.nii']);
            
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
                    
                    fprintf(['\nMask: ' roiName{1} '\n\n']);
                    
                    %% 5 emotions
                    stim = [1 2 3 4 5]; % neutral, disgust, fear, happiness, sadness
                    
                    labels = {'1','2','3','4','5'};
                    
                %    conditionsToTest = {'fiveClassDecoding'};
                    
                        conditionsToTest = {'fiveClassDecoding',...
                        'Ne-Di','Ne-Fe','Ne-Ha','Ne-Sa',...
                        'Di-Fe','Di-Ha','Di-Sa',...
                        'Fe-Ha','Fe-Sa',...
                        'Ha-Sa'};
                    
                    for iConditionToTest = 1:length(conditionsToTest)
                                                
                            %% define the data structure with the visual data %
                            ds_vis = cosmo_fmri_dataset(resultsImageVis, 'mask', mask);
                            
                            % getting rid off zeros
                            zero_msk = all(ds_vis.samples == 0, 1);
                            
                            ds_vis = cosmo_slice(ds_vis, ~zero_msk, 2);
                            
                            %mask_size_vis = size(ds_vis.samples, 2);
                            
                            % set chunks, targets and labels                            
                            ds_vis = setTargetsChunksLabels(opt, ds_vis, stim, labels, [1]);
                            
%                             % remove constant features
%                             ds_vis = cosmo_remove_useless_data(ds_vis);
                            
%                             % Demean the every pattern to remove univariate
%                             % effect differences for the visual data
%                             meanPattern_vis = nanmean(ds_vis.samples);  % get the mean for every pattern
%                             meanPattern_vis = repmat(meanPattern_vis,1,size(ds_vis.samples,2)); % make a matrix with repmat
%                             ds_vis.samples  = ds_vis.samples - meanPattern_vis; % remove the mean from every every point in each pattern
                            
                            
                            %% define the data structure with the auditory data %
                            ds_aud = cosmo_fmri_dataset(resultsImageAud, 'mask', mask);
                            
                            % getting rid off zeros
                            zero_msk = all(ds_aud.samples == 0, 1);
                            
                            ds_aud = cosmo_slice(ds_aud, ~zero_msk, 2);
                            
                            %mask_size_aud = size(ds_aud.samples, 2);
                            
                            % set chunks, targets and labels                            
                            ds_aud = setTargetsChunksLabels(opt, ds_aud, stim, labels, [2]);
                            
%                             % remove constant features
%                             ds_aud = cosmo_remove_useless_data(ds_aud);
                            
%                             % Demean the every pattern to remove univariate
%                             % effect differences in the auditory data
%                             meanPattern_aud = nanmean(ds_aud.samples);  % get the mean for every pattern
%                             meanPattern_aud = repmat(meanPattern_aud,1,size(ds_aud.samples,2)); % make a matrix with repmat
%                             ds_aud.samples  = ds_aud.samples - meanPattern_aud; % remove the mean from every every point in each pattern
                                                       
                            
                            %% Combine the two datasets
                                    
                            ds = cosmo_stack({ds_vis,ds_aud},1,'unique');                            

                            % remove constant features
                            ds = cosmo_remove_useless_data(ds);
                            
                            % Demean the every pattern to remove univariate
                            % effect differences for the visual data
                            meanPattern = mean(ds.samples,2);  % get the mean for every pattern
                            meanPattern = repmat(meanPattern,1,size(ds.samples,2)); % make a matrix with repmat
                            ds.samples  = ds.samples - meanPattern; % remove the mean from every every point in each pattern
                            
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
                                    
                            

                            
%                             % partitioning, for test and training : cross validation
%                             partitions = cosmo_nfold_partitioner(ds);        
                            
                            %% Feature Selection - to set up crossmodal 
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
                            
                            fprintf(['  - condition: ' conditionsToTest{iConditionToTest} ', accuracy: ' num2str(accuracy) '\n\n\n']);
                            
                        %end
                        
                    end
                    

                    
                end
                
            end
            
        end
        
        % set output results dir
        pathOutput = strcat(opt.resDir);
        
%         %set names output file 
%         savefileMat = fullfile(pathOutput, ...
%             ['sub-', subID, ...
%             '_task-', opt.cosmomvpa.modalities, ...
%             '_cosmomvpa_FWHM-', num2str(funcFWHM), ...
%             '_', datestr(now, 'yyyymmdd'), '.mat' ]);
        
        savefileCsv = fullfile(pathOutput, ...
            ['sub-', subID, ...
            '_task-', opt.cosmomvpa.modalities, ...
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