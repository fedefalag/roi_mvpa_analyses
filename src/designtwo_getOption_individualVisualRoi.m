function opt = designtwo_getOption_individualVisualRoi

opt.groups = {['one']}; 

% subjects list
%opt.subjects = {['003']}; % ['001'],['002'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['021'],
opt.subjects = {['001'],['002'],['003'],['004'],['005'],['006'],['007'],['008'],['009'],['010'],['011'],['012'],['013'],['014'],['015'],['016'],['017'],['018'],['019'],['020'],['021'],['022'],['023'],['024']}; % just as reference

% ROIs
%{'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
% 1 means expand, 2 means sphere, 0 means do nothing

%opt.sphere.allLocations = {[44 -44 -26],[47 -81 -13], [-42 -89 -13]}; 

opt.rois.sub001.coord = {[46 -44 -30],[-47 -47 -26],[23 -96 -5],[-36 -91 -15],[62 -42 -5],[-62 -63 -2],[55 18 24],[-60 18 24]};
opt.rois.sub001.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub001.action = {2,2,1,1,1,1,1,2};

opt.rois.sub002.coord = {[39 -52 -15],[-44 -24 -21],[44 -73 -8],[-36 -91 -15],[52 -60 11],[-52 -52 13],[47 -5 60],[-47 -5 47]};
opt.rois.sub002.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub002.action = {2,2,2,2,1,1,1,2};

opt.rois.sub003.coord = {[36 -55 -21],[-42 -34 -15],[21 -94 5],[-29 -94 -8],[65 -44 8],[-60 -47 13],[47 5 50],[-42 -3 60]};
opt.rois.sub003.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub003.action = {2,2,2,2,1,1,1,2};

opt.rois.sub004.coord = {[39 -55 -18],[-39 -47 -23],[34 -96 -2],[-29 -89 -18],[60 -55 0],[-62 -60 13],[55 5 44],[0 0 0]};
opt.rois.sub004.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub004.action = {2,2,2,2,1,1,2,0};

opt.rois.sub005.coord = {[47 -47 -21],[-47 -60 -15],[42 -73 -8],[-47 -73 -21],[49 -55 13],[-42 -63 16],[47 2 50],[-39 5 55]};
opt.rois.sub005.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub005.action = {1,2,2,2,1,1,1,2};

opt.rois.sub006.coord = {[30 -52 -15],[-36 -63 -15],[26 -91 -10],[-21 -96 -15],[55 -60 8],[-55 -50 13],[49 8 50],[-47 2 52]};
opt.rois.sub006.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub006.action = {1,1,1,1,1,1,1,1};

opt.rois.sub007.coord = {[39 -37 -21],[-44 -47 -21],[23 -89 -18],[-23 -91 -15],[44 -42 8],[-47 -52 11],[49 0 47],[-39 -3 65]};
opt.rois.sub007.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub007.action = {1,2,2,2,1,1,2,2};

opt.rois.sub008.coord = {[44 -55 -26],[-44 -50 -26],[28 -94 -6],[-44 -83 -10],[44 -52 8],[-49 -55 8],[55 0 44],[-39 -3 47]};
opt.rois.sub008.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub008.action = {1,2,1,1,1,1,1,1};

opt.rois.sub009.coord = {[42 -57 -23],[-42 -39 -21],[36 -68 -5],[-36 -81 -8],[62 -34 5],[-55 -47 8],[49 5 47],[-47 0 47]};
opt.rois.sub009.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub009.action = {1,2,1,1,1,1,1,1};

opt.rois.sub010.coord = {[47 -52 -21],[-44 -44 -23],[49 -73 -10],[-42 -68 -10],[57 -29 5],[-47 -65 13],[49 5 47],[-44 5 44]}; % [-42 -68 -10]
opt.rois.sub010.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % lOFA has 103vx
opt.rois.sub010.action = {2,2,1,0,1,1,1,2};

opt.rois.sub011.coord = {[0 0 0],[0 0 0],[44 -78 -10],[-23 -96 0],[55 -47 5],[-60 -60 13],[49 5 47],[-42 -5 50]};
opt.rois.sub011.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub011.action = {0,0,2,1,1,1,1,1};

opt.rois.sub012.coord = {[39 -52 -21],[0,0,0],[23 -94 -5],[-31 -91 -13],[62 -52 5],[-55 -44 13],[0 0 0],[0 0 0]}; % [-31 -91 -13]
opt.rois.sub012.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % lOFA has 125vx
opt.rois.sub012.action = {2,0,1,0,1,1,0,0};

opt.rois.sub013.coord = {[36 -47 -23],[-42 -47 -23],[39 -81 -10],[-49 -76 -15],[60 -50 -5],[-60 -63 13],[47 5 55],[-47 0 52]};
opt.rois.sub013.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub013.action = {1,2,1,1,1,1,1,1};

opt.rois.sub014.coord = {[39 -52 -26],[-44 -50 -31],[49 -73 -13],[-34 -89 -2],[55 -52 5],[-62 -47 5],[55 8 44],[-49 0 50]}; % [39 -52 -26] ; [-34 -89 -2]
opt.rois.sub014.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % rFFA has 132vx ; lOFA has 117vx
opt.rois.sub014.action = {0,2,1,0,1,1,1,1};

opt.rois.sub015.coord = {[42 -42 -15],[-42 -63 -10],[34 -91 -21],[-36 -86 -21],[49 -34 -2],[-49 -39 0],[52 8 42],[-42 2 47]};
opt.rois.sub015.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub015.action = {1,1,1,2,1,1,1,1};

opt.rois.sub016.coord = {[39 -52 -23],[-42 -42 -26],[49 -76 -10],[-42 -86 -10],[60 -63 5],[-55 -70 13],[49 0 52],[-49 0 50]}; % [-42 -42 -26] ; [-42 -86 -10] ; [49 0 52]
opt.rois.sub016.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % lFFA has 136vx ; lOFA has 132vx ; rMFS has 160vx
opt.rois.sub016.action = {1,0,2,0,1,1,1,2};

opt.rois.sub017.coord = {[39 -39 -21],[-36 -55 -15],[29 -96 -5],[-44 -83 -13],[47 -52 5],[-60 -52 3],[55 5 44],[-55 15 42]};
opt.rois.sub017.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub017.action = {2,2,1,2,1,1,1,1};

opt.rois.sub018.coord = {[39 -60 -18],[-36 -65 -15],[39 -81 -10],[-23 -86 -8],[62 -50 11],[-60 -47 8],[42 2 52],[-39 -8 55]};
opt.rois.sub018.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % lOFA mask missing
opt.rois.sub018.action = {1,1,1,2,1,1,1,1};

opt.rois.sub019.coord = {[42 -47 -18],[0,0,0],[21 -99 -5],[-42 -86 -10],[47 -34 3],[-55 -39 5],[49 10 47],[-44 0 57]};
opt.rois.sub019.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub019.action = {2,0,1,1,1,1,1,1};

opt.rois.sub020.coord = {[42 -47 -23],[-36 -47 -23],[0,0,0],[0,0,0],[47 -55 5],[-44 -57 8],[52 2 47],[-47 -5 42]}; % [42 -47 -23] ; -36 -47 -23
opt.rois.sub020.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % rFFA has 124vx ; lFFA has 100vx
opt.rois.sub020.action = {0,0,0,0,1,2,2,2};

opt.rois.sub021.coord = {[44 -42 -15],[-36 -60 -10],[44 -78 -5],[-31 -94 -8],[57 -44 8],[-44 -55 11],[55 0 52],[-39 -8 55]}; % [44 -42 -15] ; [44 -78 -5] ; [-31 -94 -8]
opt.rois.sub021.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'}; % rFFA has 122vx ; rOFA has 127vx ; lOFA has 147vx
opt.rois.sub021.action = {0,2,0,0,1,1,1,1};

opt.rois.sub022.coord = {[47 -42 -23],[-39 -42 -23],[39 -86 -15],[-42 -83 -15],[52 -44 5],[-49 -44 3]}; % [47 -42 -23] ; [39 -86 -15]
opt.rois.sub022.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS'}; % rFFA has 113vx ; rOFA has 115vx
opt.rois.sub022.action = {0,2,0,2,1,1,2,2};

opt.rois.sub023.coord = {[42 -57 -13],[-47 -60 -23],[42 -73 -15],[-26 -99 -13],[52 -42 8],[-57 -50 13],[49 2 52],[-57 -5 47]};
opt.rois.sub023.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub023.action = {1,1,1,1,1,1,1,1};

opt.rois.sub024.coord = {[0,0,0],[-47 -65 -18],[0,0,0],[-29 -94 -13],[0,0,0],[-60 -47 5],[0,0,0],[-44 5 55]};
opt.rois.sub024.names = {'rFFA','lFFA','rOFA','lOFA','rpSTS','lpSTS','rMFS','lMFS'};
opt.rois.sub024.action = {0,1,0,1,0,1,0,1};



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
    
    if opt.subjects{1,n} == '001'
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
opt.betaPath = '/Users/falagiarda/project-combiemo-playaround/design-two/derivatives/cpp_spm/sub-001/stats/ffx_task-eventrelatedCombiemoVisual/ffx_space-MNI_FWHM-2/beta_0001.nii';
opt.betaForSphere = '/Users/falagiarda/project-combiemo-playaround/design-two/localizers_individual_area/beta0001.nii';

opt.saveImg = 1;

end