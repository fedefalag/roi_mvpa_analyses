% cosmo MVPA

% run opt = designtwo_byStim_overlap_getOption(); first

function designtwo_byStim_cosmomvpa_overlapRois(opt, funcFWHM)

% be very verbose please
cosmo_warning('off')

% get ROI paths
%derivativesDirCheck = regexp(opt.derivativesDir, filesep ,'split');

%if ~strcmp(derivativesDirCheck(length(derivativesDirCheck)), 'derivatives')
    
%    derivativesDir = fullfile(opt.derivativesDir, '..');
    
%else
    
    derivativesDir = opt.derivativesDir;
    
%end

% combine these two with subj nr in the middle
pathMask = opt.maskDir;

%% Loop through groups and subjects

%subjects = opt.subjects;

for iTask = 2:2%length(opt.tasks)
    

    if iTask == 1
        opt.subjects = opt.subjectsVisual;
    elseif iTask == 2
        opt.subjects = opt.subjectsAuditory;
    elseif iTask == 3
        opt.subjects = opt.subjectsBimodal;
    end
    
    opt.taskName = opt.tasks{iTask};
    
    [~, opt] = getData(opt);

%for iSub = 1:group(iGroup).numSub
for iSub = 1:length(opt.subjects)
                
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
            'accuracy', [], ...
            'stimOne', [], ...
            'stimTwo', []);
        
        % get FFX path
        subID = opt.subjects{iSub};
        groupName = 'withinSubj';
        
        pathData = strcat(opt.derivativesDataDir,'sub-',subID,'/stats/ffx_task-',opt.tasks{iTask},'/ffx_space-MNI_FWHM-',num2str(funcFWHM),'/');
        
        fprintf(['\n For subj: ' subID '\n\n']);
        
        % loop through ffxResults (beta and tmaps)
        
        count = 1;
        
        for iFfxResult = 1:length(opt.cosmomvpa.ffxResults)
            
            fprintf(['\n For ffx result: ' opt.cosmomvpa.ffxResults{iFfxResult} '\n\n']);
            
            % set the 4D result image
            resultsImage = fullfile(pathData,['4D_' opt.cosmomvpa.ffxResults{iFfxResult} '_' num2str(funcFWHM) '.nii']);
            
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
                roiPattern = fullfile(strcat(pathMask,opt.maskNames{iRoi}));
                
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
                    
                    %% 20 stimuli
                    stim = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; 
                
                    labels = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'};
                    
                    conditionsToTest = {'1-2','1-3','1-4','1-5','1-6','1-7','1-8','1-9','1-10','1-11','1-12','1-13','1-14','1-15','1-16','1-17','1-18','1-19','1-20',...
                        '2-3','2-4','2-5','2-6','2-7','2-8','2-9','2-10','2-11','2-12','2-13','2-14','2-15','2-16','2-17','2-18','2-19','2-20',...
                        '3-4','3-5','3-6','3-7','3-9','3-8','3-10','3-11','3-12','3-13','3-14','3-15','3-16','3-17','3-18','3-19','3-20',...
                        '4-5','4-6','4-7','4-8','4-9','4-10','4-11','4-12','4-13','4-14','4-15','4-16','4-17','4-18','4-19','4-20',...
                        '5-6','5-7','5-8','5-9','5-10','5-11','5-12','5-13','5-14','5-15','5-16','5-17','5-18','5-19','5-20',...
                        '6-7','6-8','6-9','6-10','6-11','6-12','6-13','6-14','6-15','6-16','6-17','6-18','6-19','6-20',...
                        '7-8','7-9','7-10','7-11','7-12','7-13','7-14','7-15','7-16','7-17','7-18','7-19','7-20',...
                        '8-9','8-10','8-11','8-12','8-13','8-14','8-15','8-16','8-17','8-18','8-19','8-20',...
                        '9-10','9-11','9-12','9-13','9-14','9-15','9-16','9-17','9-18','9-19','9-20',...
                        '10-11','10-12','10-13','10-14','10-15','10-16','10-17','10-18','10-19','10-20',...
                        '11-12','11-13','11-14','11-15','11-16','11-17','11-18','11-19','11-20',...
                        '12-13','12-14','12-15','12-16','12-17','12-18','12-19','12-20',...
                        '13-14','13-15','13-16','13-17','13-18','13-19','13-20',...
                        '14-15','14-16','14-17','14-18','14-19','14-20',...
                        '15-16','15-17','15-18','15-19','15-20',...
                        '16-17','16-18','16-19','16-20',...
                        '17-18','17-19','17-20',...
                        '18-19','18-20',...
                        '19-20'};
                    
                    for iConditionToTest = 1:length(conditionsToTest)                        
                        
                            
                            % define the data structure
                            ds = cosmo_fmri_dataset(resultsImage, 'mask', mask);
                          
                            %cosmo_disp(ds);
                            
                            % getting rid off zeros
                            zero_msk = all(ds.samples == 0, 1);
                            
                            ds = cosmo_slice(ds, ~zero_msk, 2);
                            
                            mask_size = size(ds.samples, 2);
                            
                            % set chunks, targets and labels
                            
                            ds = setTargetsChunksLabels(opt, ds, stim, labels);
                                    
% 20 stimuli and all their combinations
                    if strcmp(conditionsToTest{iConditionToTest}, '1-2')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 2);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-3')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 3);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-4')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 4);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-5')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 5);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-6')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 6);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '1-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 1 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-3')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 3);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-4')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 4);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-5')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 5);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-6')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 6);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '2-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 2 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-4')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 4);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-5')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 5);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-6')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 6);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '3-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 3 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-5')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 5);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-6')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 6);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '4-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 4 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-6')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 6);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '5-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 5 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-7')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 7);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '6-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 6 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-8')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 8);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '7-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-9')
                        ds = cosmo_slice(ds, ds.sa.targets == 7 | ds.sa.targets == 9);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '8-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 8 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-10')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 10);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '9-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 9 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-11')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 11);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '10-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 10 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-12')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 12);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '11-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 11 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-13')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 13);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '12-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 12 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-14')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 14);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '13-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 13 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-15')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 15);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '14-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 14 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '15-16')
                        ds = cosmo_slice(ds, ds.sa.targets == 15 | ds.sa.targets == 16);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '15-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 15 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '15-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 15 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '15-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 15 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '15-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 15 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '16-17')
                        ds = cosmo_slice(ds, ds.sa.targets == 16 | ds.sa.targets == 17);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '16-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 16 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '16-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 16 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '16-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 16 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '17-18')
                        ds = cosmo_slice(ds, ds.sa.targets == 17 | ds.sa.targets == 18);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '17-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 17 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '17-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 17 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '18-19')
                        ds = cosmo_slice(ds, ds.sa.targets == 18 | ds.sa.targets == 19);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '18-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 18 | ds.sa.targets == 20);
                    elseif strcmp(conditionsToTest{iConditionToTest}, '19-20')
                        ds = cosmo_slice(ds, ds.sa.targets == 19 | ds.sa.targets == 20);
                    end
                                    
                            
                            % remove constant features
                            ds = cosmo_remove_useless_data(ds);
                            
                            % partitioning, for test and training : cross validation
                            partitions = cosmo_nfold_partitioner(ds);                            
                                                       
                            % ROI mvpa analysis
                            [~, accuracy] = cosmo_crossvalidate(ds, ...
                                @cosmo_meta_feature_selection_classifier, ...
                                partitions, opt.cosmomvpa);
                            
                                                %stimulus labels
                    thisBinaryPairLabels=unique(ds.sa.targets);
                    stimOne = thisBinaryPairLabels(1);
                    stimTwo = thisBinaryPairLabels(2);
                            
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
                                accuracy, ...
                        stimOne, ...
                        stimTwo);
                            
                            count = count + 1;
                            
                            fprintf(['  - condition: ' conditionsToTest{iConditionToTest} ', accuracy: ' num2str(accuracy) '\n\n\n']);
                            
                        %end
                        
                    end
                      
                    
                end
                
            end
            
        end
        
        % set output results dir
        pathOutput = strcat(opt.resDir,'MVPA_by_stimulus/');
        
        %set names output file 
        savefileMat = fullfile(pathOutput, ...
            ['sub-', subID, ...
            '_task-', opt.taskName, ...
            '_cosmomvpa_FWHM-', num2str(funcFWHM), ...
            '_', datestr(now, 'yyyymmdd'), '.mat' ]);
        
        savefileCsv = fullfile(pathOutput, ...
            ['sub-', subID, ...
            '_task-', opt.taskName, ...
            '_cosmomvpa_FWHM-', num2str(funcFWHM), ...
            '_', datestr(now, 'yyyymmdd'), '.csv' ]);        
        
        save(savefileMat, 'accu');
        
        writetable(struct2table(accu), savefileCsv)
        
end
end
    
end

function ds = setTargetsChunksLabels(opt, ds, stim, labels)

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

ds.sa.targets = targets;
ds.sa.chunks = chunks;
ds.sa.labels = labels;

end


function  accu = storeResults(accu, count, subID, groupName, roiName, ...
    roiDimension, mask_size, ffxResult, conditionName, modality, accuracy, stimOne, stimTwo, ~)

% store results
accu(count).sub = subID;
accu(count).group = groupName;
accu(count).ffxResults = ffxResult;
accu(count).roiArea = roiName;
accu(count).roiDimension = roiDimension;
accu(count).roiNbVoxels = mask_size;
accu(count).conditions = conditionName;
accu(count).modality = modality;
accu(count).accuracy = accuracy;
accu(count).stimOne = stimOne;
accu(count).stimTwo = stimTwo;
%accu(count).predictors = pred;

end