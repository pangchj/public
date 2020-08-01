#Converts the files that we want to change from SVGZ format to SVG format.

# It is assumed that the images of your lyx files are in the following folder. Do change it if otherwise.
dir_lyx_img=/usr/share/lyx/images


# Start of script to create the dark theme icons.
dir_of_lyx_dt_sh=$PWD

cp -r $dir_lyx_img $dir_lyx_img/../images_backup
echo "Copied original images into folder:"
echo $dir_lyx_img/../images_backup

find $dir_lyx_img/ -type f -name "*.png" -exec convert {} -negate {} \;

echo "Finished inverting png images in classic icon set"

cd $dir_lyx_img/math
gunzip -S z *.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh *.svg
gzip -S z *.svg

echo "Finished coloring images in ../images/math/ subfolder"

cd $dir_lyx_img/ipa
gunzip -S z *.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh *.svg
gzip -S z *.svg

echo "Finished coloring images in ../images/ipa/ subfolder"

cd $dir_lyx_img

rm ./banner.svgz

gunzip -S z special*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh special*.svg
gzip -S z special*.svg

gunzip -S z info\-insert.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh info\-insert.svg
gzip -S z info\-insert.svg

gunzip -S z scri*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh scri*.svg
gzip -S z scri*.svg

echo "Finished coloring images in ../images/ipa/ subfolder"

