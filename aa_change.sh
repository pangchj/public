# This shell script changes (in Linux) the colors of lyx icons so that it is suitable for a dark theme. 
#####

# Usage:
#  1. Copy both aa_change.sh and aa_subroutine.sh to the same directory.
#  2. Set both files to executable by "chmod +x aa_change.sh" and "chmod +x aa_subroutine.sh"
#  3. Run this script with "sudo aa_change.sh"


# It is assumed that the images of your lyx files are in the following folder. Do change it if otherwise.
dir_lyx_img=/usr/share/lyx/images

# If you want to change the Math/ IPA/ Unicode icons to a different color, feel free to adjust the aa_subroutine.sh script.

# Start of script to create the dark theme icons.
dir_of_lyx_dt_sh=$PWD

#####

cp -r $dir_lyx_img $dir_lyx_img/../images_backup
echo "Copied original images into folder:" $dir_lyx_img"/../images_backup"

#####

find $dir_lyx_img/ -type f -name "*.png" -exec convert {} -negate {} \;
echo "Inverted png images in classic icon set"

#####

cd $dir_lyx_img/math
gunzip -S z *.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g" *.svg
gzip -S z *.svg
echo "Colored images in" $dir_lyx_img"/math/"

####

cd $dir_lyx_img/ipa
gunzip -S z *.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" *.svg
gzip -S z *.svg
echo "Colored images in" $dir_lyx_img"/ipa/"

#####

cd $dir_lyx_img
rm ./banner.svgz

gunzip -S z special*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" special*.svg
gzip -S z special*.svg

gunzip -S z info\-insert.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" info\-insert.svg
gzip -S z info\-insert.svg

gunzip -S z scri*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" scri*.svg
gzip -S z scri*.svg

## Math icons are experimental: More can be done to make the output look better.

gunzip -S z math*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" math*.svg
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/#800000/#ff8000/g; s/#008000/#80ff00/g; s/#000080/#ffff00/g; s/#323232/#ffff00/g" math*.svg
gzip -S z math*.svg

gunzip -S z ert\-insert.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" ert\-insert*.svg
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/#800000/#ff8000/g; s/#008000/#80ff00/g; s/#000080/#ffff00/g; s/#323232/#ffff00/g" ert\-insert*.svg
gzip -S z ert\-insert*.svg

gunzip -S z dialog\-show_ma*.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/<path/<path\ fill='#ffff00'\ /g ;s/#000000/#ffff00/g; s/fill:black/fill:yellow/g" dialog\-show_ma*.svg
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/#800000/#ff8000/g; s/#008000/#80ff00/g; s/#000080/#ffff00/g; s/#323232/#ffff00/g" dialog\-show_ma*.svg
gzip -S z dialog\-show_ma*.svg

# Invert colors for icons related to tables
# (The SVGZ files can be scaled well. The PNG files cannot.)
# (Also, the classic icon set does not include some icons.)
gunzip -S z *.svgz
$dir_of_lyx_dt_sh/aa_subroutine.sh "s/#dae3ea/#251c15/g; s/#e9eef2/#16110d/g; s/#a5bbd3/#5a442c/g; s/#ffffff/#000000/g; s/#023372/#fdcc8d/g; s/#16477c/#e9b883/g; s/#d6e9f8/#291607/g; s/#c1ddf5/#3e220a/g; s/#84abf4/#7b540b/g; s/#6e757b/#918a84/g; s/#84abf4/#7b540b/g; s/#99a2a9/#665d56/g; s/#1a4f8b/#e5b074/g; s/#8db1cc/#724e33/g" *.svg
gzip -S z *.svg 

# Replace some icons in the Classic *.png set with those that we colored earlier.
cd $dir_lyx_img/classic
cp ../dialog\-show_ma*.svgz ./
cp ../math*.svgz ./
cp ../scri*.svgz ./
cp ../ert\-insert.svgz ./

rm ./dialog\-show_ma*.png
rm ./math*.png
rm ./scri*.png
rm ./ert\-insert.png

echo "Colored chosen images in" $dir_lyx_img"/"
