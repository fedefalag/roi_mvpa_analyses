% Count voxels in a binary nifti image

% load image thru load_nii (from nifti tools)

yourImage = load_nii('yourImageURL');

% count how many Ones there are
sum(yourImage.img(:));

