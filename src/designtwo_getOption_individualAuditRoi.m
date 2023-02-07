function opt = designtwo_getOption_individualAuditRoi

opt.groups = {['one']}; 

% subjects list
opt.subjects = {['022']}; % ['001'],['002'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['021'],
%opt.subjects = {['001'],['002'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']}; % just as reference

% ROIs
%{'rTVA','lTVA','rMFS','lMFS'};
% 1 means expand, 2 means sphere, 0 means do nothing

%opt.sphere.allLocations = {[44 -44 -26],[47 -81 -13], [-42 -89 -13]}; 

opt.rois.sub001.coord = {[65 -5 0],[-68 -29 11],[52 -11 42],[-52 -11 44]};
opt.rois.sub001.names = {'rTVA','lTVA','rMFS','lMFS'}; % rMFS has 116vx ; lMFS has 114vx
opt.rois.sub001.action = {1,1,0,0}; 

opt.rois.sub002.coord = {[68 -31 0],[-65 -5 3],[47 -8 57],[-49 -8 52]};
opt.rois.sub002.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub002.action = {1,1,2,1};

% opt.rois.sub003.coord = {};
% opt.rois.sub003.names = {'rTVA','lTVA','rMFS','lMFS'};
% opt.rois.sub003.action = {};

opt.rois.sub004.coord = {[57 -24 -5],[-68 -34 5],[0 0 0],[0 0 0]};
opt.rois.sub004.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub004.action = {1,1,0,0};

opt.rois.sub005.coord = {[62 -18 -5],[-57 -11 3],[52 -3 47],[-49 -3 50]};
opt.rois.sub005.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub005.action = {1,1,1,1};

opt.rois.sub006.coord = {[62 -31 3],[-65 -34 11],[0 0 0],[0 0 0]};
opt.rois.sub006.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub006.action = {1,1,0,0};

opt.rois.sub007.coord = {[52 -29 3],[-68 -21 8],[55 0 47],[-44 -5 55]};
opt.rois.sub007.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub007.action = {1,1,2,2};

opt.rois.sub008.coord = {[47 -39 11],[-57 -44 16],[57 0 44],[-55 -3 50]};
opt.rois.sub008.names = {'rTVA','lTVA','rMFS','lMFS'}; % rMFS has 144vx
opt.rois.sub008.action = {1,1,0,1};

opt.rois.sub009.coord = {[70 -18 13],[-68 -29 11],[55 -3 55],[-49 -3 50]};
opt.rois.sub009.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub009.action = {1,1,1,1};

opt.rois.sub010.coord = {[65 0 -2],[-60 -18 11],[44 2 47],[-52 -5 47]}; % 
opt.rois.sub010.names = {'rTVA','lTVA','rMFS','lMFS'}; % rMFS has 118vx
opt.rois.sub010.action = {1,1,0,1};

opt.rois.sub011.coord = {[55 -31 8],[-60 -26 8],[49 0 47],[-44 8 34]};
opt.rois.sub011.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub011.action = {1,1,1,1};

opt.rois.sub012.coord = {[70 -16 3],[-65 -26 5],[49 2 52],[-49 -3 52]};
opt.rois.sub012.names = {'rTVA','lTVA','rMFS','lMFS'}; % lMFS has 112vx
opt.rois.sub012.action = {1,1,1,0};

opt.rois.sub013.coord = {[49 -31 5],[-65 -8 -2],[47 -5 44],[-47 5 55]};
opt.rois.sub013.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub013.action = {1,1,2,2};

opt.rois.sub014.coord = {[60 -11 -5],[-60 -8 -5],[55 5 42],[-47 --5 52]};
opt.rois.sub014.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub014.action = {1,1,1,1};

opt.rois.sub015.coord = {[65 -13 3],[-62 -16 0],[57 2 42],[-42 2 47]};
opt.rois.sub015.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub015.action = {1,1,1,1};

opt.rois.sub016.coord = {[60 -5 -8],[-62 -3 -5],[55 5 44],[-52 -5 47]};
opt.rois.sub016.names = {'rTVA','lTVA','rMFS','lMFS'}; % rMFS has 147vx
opt.rois.sub016.action = {1,1,0,1};

opt.rois.sub017.coord = {[57 -24 -5],[-65 -11 0],[55 0 52],[-52 -3 55]};
opt.rois.sub017.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub017.action = {1,1,1,1};

opt.rois.sub018.coord = {[62 -3 -8],[-52 -13 5],[52 -5 44],[-52 -8 52]};
opt.rois.sub018.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub018.action = {1,1,2,2};

opt.rois.sub019.coord = {[62 -24 -5],[-68 -18 -2],[49 5 47],[-49 5 44]};
opt.rois.sub019.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub019.action = {1,1,1,1};

opt.rois.sub020.coord = {[60 -13 5],[-55 -13 5],[55 0 42],[-52 -11 47]};
opt.rois.sub020.names = {'rTVA','lTVA','rMFS','lMFS'}; % lMFS has 137vx
opt.rois.sub020.action = {1,1,1,0};

opt.rois.sub021.coord = {[62 -16 -5],[-62 -18 -2],[0 0 0],[0 0 0]};
opt.rois.sub021.names = {'rTVA','lTVA','rMFS','lMFS'}; % lTVA has 152vx
opt.rois.sub021.action = {1,0,0,0};

opt.rois.sub022.coord = {[60 0 -5],[-57 -13 0],[52 0 50],[-55 -5 47]};
opt.rois.sub022.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub022.action = {1,1,1,1};

opt.rois.sub023.coord = {[60 -29 -5],[-65 -31 5],[49 0 50],[-44 0 55]};
opt.rois.sub023.names = {'rTVA','lTVA','rMFS','lMFS'}; % rMFS has 157vx
opt.rois.sub023.action = {1,1,0,1};

opt.rois.sub024.coord = {[62 -16 0],[-65 -16 -2],[0 0 0],[0 0 0]};
opt.rois.sub024.names = {'rTVA','lTVA','rMFS','lMFS'};
opt.rois.sub024.action = {1,1,0,0};



opt.sphere.radius = 4; % starting radius
opt.sphere.maxNbVoxels = 150;

% Smoothing level of localizer and data respectively
opt.locFWHM = 6;
opt.eventFWHM = 2;
 
%opt.locPath = '/Users/falagiarda/project-combiemo-playaround/only_localizers_analyses/derivatives-face/derivatives/cpp_spm/';
%opt.maskPath = '/stats/ffx_task-facelocalizerCombiemo/ffx_space-MNI_FWHM-';

opt.maskPath = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/';

% build structure with all subjects coordinates of the ROIs we want to try to create %
for n = 1:length(opt.subjects)
    
    if opt.subjects{n} == '001'
        opt.rois.curr.coord = opt.rois.sub001.coord;
        opt.rois.curr.names = opt.rois.sub001.names;
        opt.rois.curr.action = opt.rois.sub001.action;
        
    elseif opt.subjects{n} == '002'
        opt.rois.curr.coord = opt.rois.sub002.coord;
        opt.rois.curr.names = opt.rois.sub002.names;
        opt.rois.curr.action = opt.rois.sub002.action;
        
    elseif opt.subjects{n} == '003'
        opt.rois.curr.coord = opt.rois.sub003.coord;
        opt.rois.curr.names = opt.rois.sub003.names;
        opt.rois.curr.action = opt.rois.sub003.action;
        
    elseif opt.subjects{n} == '004'
        opt.rois.curr.coord = opt.rois.sub004.coord;
        opt.rois.curr.names = opt.rois.sub004.names;
        opt.rois.curr.action = opt.rois.sub004.action;
        
    elseif opt.subjects{n} == '005'
        opt.rois.curr.coord = opt.rois.sub005.coord;
        opt.rois.curr.names = opt.rois.sub005.names;
        opt.rois.curr.action = opt.rois.sub005.action;
        
    elseif opt.subjects{n} == '006'
        opt.rois.curr.coord = opt.rois.sub006.coord;
        opt.rois.curr.names = opt.rois.sub006.names;
        opt.rois.curr.action = opt.rois.sub006.action;
        
    elseif opt.subjects{n} == '007'
        opt.rois.curr.coord = opt.rois.sub007.coord;
        opt.rois.curr.names = opt.rois.sub007.names;
        opt.rois.curr.action = opt.rois.sub007.action;
        
    elseif opt.subjects{n} == '008'
        opt.rois.curr.coord = opt.rois.sub008.coord;
        opt.rois.curr.names = opt.rois.sub008.names;
        opt.rois.curr.action = opt.rois.sub008.action;
        
    elseif opt.subjects{n} == '009'
        opt.rois.curr.coord = opt.rois.sub009.coord;
        opt.rois.curr.names = opt.rois.sub009.names;
        opt.rois.curr.action = opt.rois.sub009.action;
        
    elseif opt.subjects{n} == '010'
        opt.rois.curr.coord = opt.rois.sub010.coord;
        opt.rois.curr.names = opt.rois.sub010.names;
        opt.rois.curr.action = opt.rois.sub010.action;
        
    elseif opt.subjects{n} == '011'
        opt.rois.curr.coord = opt.rois.sub011.coord;
        opt.rois.curr.names = opt.rois.sub011.names;
        opt.rois.curr.action = opt.rois.sub011.action;
        
    elseif opt.subjects{n} == '012'
        opt.rois.curr.coord = opt.rois.sub012.coord;
        opt.rois.curr.names = opt.rois.sub012.names;
        opt.rois.curr.action = opt.rois.sub012.action;
        
    elseif opt.subjects{n} == '013'
        opt.rois.curr.coord = opt.rois.sub013.coord;
        opt.rois.curr.names = opt.rois.sub013.names;
        opt.rois.curr.action = opt.rois.sub013.action;
        
    elseif opt.subjects{n} == '014'
        opt.rois.curr.coord = opt.rois.sub014.coord;
        opt.rois.curr.names = opt.rois.sub014.names;
        opt.rois.curr.action = opt.rois.sub014.action;
        
    elseif opt.subjects{n} == '015'
        opt.rois.curr.coord = opt.rois.sub015.coord;
        opt.rois.curr.names = opt.rois.sub015.names;
        opt.rois.curr.action = opt.rois.sub015.action;
        
    elseif opt.subjects{n} == '016'
        opt.rois.curr.coord = opt.rois.sub016.coord;
        opt.rois.curr.names = opt.rois.sub016.names;
        opt.rois.curr.action = opt.rois.sub016.action;
        
    elseif opt.subjects{n} == '017'
        opt.rois.curr.coord = opt.rois.sub017.coord;
        opt.rois.curr.names = opt.rois.sub017.names;
        opt.rois.curr.action = opt.rois.sub017.action;
        
    elseif opt.subjects{n} == '018'
        opt.rois.curr.coord = opt.rois.sub018.coord;
        opt.rois.curr.names = opt.rois.sub018.names;
        opt.rois.curr.action = opt.rois.sub018.action;
        
    elseif opt.subjects{n} == '019'
        opt.rois.curr.coord = opt.rois.sub019.coord;
        opt.rois.curr.names = opt.rois.sub019.names;
        opt.rois.curr.action = opt.rois.sub019.action;
        
    elseif opt.subjects{n} == '020'
        opt.rois.curr.coord = opt.rois.sub020.coord;
        opt.rois.curr.names = opt.rois.sub020.names;
        opt.rois.curr.action = opt.rois.sub020.action;
        
    elseif opt.subjects{n} == '021'
        opt.rois.curr.coord = opt.rois.sub021.coord;
        opt.rois.curr.names = opt.rois.sub021.names;
        opt.rois.curr.action = opt.rois.sub021.action;
        
    elseif opt.subjects{n} == '022'
        opt.rois.curr.coord = opt.rois.sub022.coord;
        opt.rois.curr.names = opt.rois.sub022.names;
        opt.rois.curr.action = opt.rois.sub022.action;
        
    elseif opt.subjects{n} == '023'
        opt.rois.curr.coord = opt.rois.sub023.coord;
        opt.rois.curr.names = opt.rois.sub023.names;
        opt.rois.curr.action = opt.rois.sub023.action;
        
    elseif opt.subjects{n} == '024'
        opt.rois.curr.coord = opt.rois.sub024.coord;
        opt.rois.curr.names = opt.rois.sub024.names;
        opt.rois.curr.action = opt.rois.sub024.action;
        
    end
    
opt.mask{n}.coordinates = opt.rois.curr.coord;
opt.mask{n}.roiname = opt.rois.curr.names;
opt.mask{n}.action = opt.rois.curr.action;

end

opt.dataPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/';
opt.betaPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/sub-001/stats/ffx_task-eventrelatedCombiemoAuditory/ffx_space-MNI_FWHM-2/beta_0001.nii';
opt.betaForSphere = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/beta0001.nii';

opt.saveImg = 1;

end