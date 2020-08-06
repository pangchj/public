######################################################
# This shell script changes (in Linux) the colors of #
# lyx icons so that it is suitable for a dark theme. #
#                                                    #
# Author: pangchj                                    #
#                                                    #
# Available on https://github.com/pangchj/public     #
# If this code is useful to you in any way, do Star  #
# the github page!                                   #
######################################################

# Changes from last version: 
# -Isolated important variables that can be adjusted easily to 
#     create your favorite dark theme icons
# -Script can also be easily re-run to find your favorite settings
# -Can invert the colors of SVGZ images to some degree
# -Includes my personal settings for combining best icons from 
#     Classic and Default icon themes (in the new classic icon theme).
# -First version I put my username in the code.

# Usage:
#  1. Copy both aa_change.sh and aa_subroutine.sh to the same directory.
#  2. Set both files to executable by 
#        "chmod +x aa_change.sh aa_subroutine.s"
#  3. Run this script with "sudo ./aa_change.sh" from the directory.

# BEFORE YOU BEGIN:
#
# Look ahead at the first if-statement. It first checks whether 
#  $dir_lyx_img/../images_backup exists. If it does, it is assumed to contain the 
# original images. If this directory does not exist, then the if-statement expects the
# original images to be in $dir_lyx_img .

##########################
# Adjustable parameters: #
##########################

# If your lyx icon files are in another folder, do change the following.

dir_lyx_img=/usr/share/lyx/images

# State the RGB bright color that you want to transform to (from black). 
# What is best for you depends on your screen brightness, background lighting etc.
# Hints: #ffffff: White 
#        #ffff00: Yellow: Blue channel set to zero
#        #ffbf00: Blue channel set to zero, Green to 75%

bright_color=#ffbf00

# State the Blue and Green multipliers that you want for the (inverted) PNG files
# Both numbers are between 0 and 1. 
# To filter more blue light, set B_mult to as low as you think is comfortable, 
#     followed by reducing G_mult from 1 to as low as you think comfortable.

B_mult=0
G_mult=0.75

# I have replaced some classic PNG icons with default SVGZ icons 
#    (because SVGZ icons scale, and PNG icons do not), and also edited
#    some images manually.
# Enter either "y" if you want to use my choice, or "n" otherwise.

my_icons="y"

###########################################################################
# Start of script: You probably don't want to edit the file from here on. #
###########################################################################

# Start of script to create the dark theme icons.
dir_cur=$PWD

#####

cd $dir_lyx_img/../

if [ -d images_backup ] ; then

# If exists this directory, then copy images from that directory
rm -r images
cp -r ./images_backup ./images
echo "Recovered original images from "$dir_lyx_img"/../images_backup"

else

# Otherwise copy the images directory to images_backup
cp -r $dir_lyx_img $dir_lyx_img/../images_backup
echo "Copied original images into folder " $dir_lyx_img"/../images_backup"
fi

#####

find $dir_lyx_img/ -type f -name "*.png" -exec convert {} -negate -channel B -evaluate multiply $B_mult -channel G -evaluate multiply $G_mult +channel {} \;
echo "Inverted png images, reduced blue & green channels in classic icon set"

#####

pat0="s/<path/<path\ fill='"$bright_color"'\ /g ;s/#000000/"$bright_color"/g"

cd $dir_lyx_img/math
gunzip -S z *.svgz
$dir_cur/aa_subroutine.sh "$pat0" *.svg
gzip -S z *.svg
echo "Colored images in" $dir_lyx_img"/math/"

####

pat1=$pat0"; s/fill:black/fill:'"$bright_color"'/g"

cd $dir_lyx_img/ipa
gunzip -S z *.svgz
$dir_cur/aa_subroutine.sh "$pat1" *.svg
gzip -S z *.svg
echo "Colored images in" $dir_lyx_img"/ipa/"

#####

cd $dir_lyx_img

rm ./banner.svgz

# Invert colors for all other SVGZ files

long_line='s{(#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])}{ ($new=$1) =~ tr/0123456789abcdef/fedcba9876543210/; $new }e'

# If you want to understand the perl command below, go to https://unix.stackexchange.com/questions/246734/can-sed-y-commands-be-applied-only-to-matching-text-instead-of-to-the-entire

gunzip -S z *.svgz
for x in *.svg
do
perl -pe "$long_line" $x > t1$x
mv t1$x $x
done
$dir_cur/aa_subroutine.sh "s/#ffffff/"$bright_color"/g; s/fill:black/fill:'"$bright_color"'/g" *.svg
gzip -S z *.svg 

cd $dir_lyx_img/oxygen
gunzip -S z *.svgz
for x in *.svg
do
perl -pe "$long_line" $x > t1$x
mv t1$x $x
done
$dir_cur/aa_subroutine.sh "s/#ffffff/"$bright_color"/g; s/fill:black/fill:'"$bright_color"'/g" *.svg
gzip -S z *.svg 

echo "Inverted SVGZ images in" $dir_lyx_img"/"
echo "   and "$dir_lyx_img"/oxygen/ as best as I can"

if [ "$my_icons" = "y" ]; then 
# Replace some icons in the Classic *.png set with those that we colored earlier.

cd $dir_lyx_img/classic

# Copy the SVGZ files that needed the sed to "<path\ fill='"$bright_color"'\ "

cp ../dialog\-show_ma*.svgz ./
cp ../ert\-insert.svgz ./
cp ../math*.svgz ./
cp ../scri*.svgz ./
cp ../tabular\-feature_al*.svgz ./
cp ../tabular\-feature_m\-*.svgz ./
cp ../tabular\-feature_mul*.svgz ./
cp ../tabular\-feature_set\-r*.svgz ./
cp ../specialchar-insert_menu-separator.svgz ./
cp ../spelling-continuously.svgz ./

gunzip -S z *.svgz
$dir_cur/aa_subroutine.sh "s/<path/<path\ fill='"$bright_color"'\ /g" *.svg
$dir_cur/aa_subroutine.sh "s/#989898/"$bright_color"/g" tabular\-feature_m\-al*.svg
$dir_cur/aa_subroutine.sh "s/#cdcdcd/"$bright_color"/g" math\-display.svg

# These icons needed to change color from #efebe7 to $bright_color

cp ../tabular\-feature_set\-a*.svgz ./
cp ../tabular\-feature_set\-b*.svgz ./
cp ../tabular\-feature_set\-i*.svgz ./
cp ../tabular\-feature_toggle\-l*.svgz ./
cp ../tabular\-feature_unset*.svgz ./

gunzip -S z *.svgz
$dir_cur/aa_subroutine.sh "s/#efebe7/"$bright_color"/g" tabular\-feature_set\-a*.svg tabular\-feature_set\-b*.svg tabular\-feature_set\-i*.svg tabular\-feature_toggle\-l*.svg tabular\-feature_unset*.svg

# These icons do not need mofication

cp ../tabular\-feature_mo*.svgz ./
cp ../tabular\-feature_ap*.svgz ./
cp ../tabular\-feature_de*.svgz ./

gzip -S z *.svg

rm ./dialog\-show_ma*.png 
rm ./ert\-insert.png
rm ./math*.png
rm ./scri*.png 
rm ./tabular\-feature_al*.png
rm ./tabular\-feature_m\-*.png 
rm ./tabular\-feature_mul*.png 

rm ./tabular\-feature_set\-a*.png
rm ./tabular\-feature_set\-b*.png
rm ./tabular\-feature_set\-i*.png
rm ./tabular\-feature_toggle\-l*.png
rm ./tabular\-feature_unset*.png

rm ./tabular\-feature_ap*.png
rm ./tabular\-feature_de*.png

echo "Colored SVGZ images according to my style in" $dir_lyx_img"/"
fi

# Somehow there is one image that isn't handled well. This code addresses the exception.
cp $dir_lyx_img/../images_backup/classic/buffer\-write.png  $dir_lyx_img/classic/buffer\-write.png
cd $dir_lyx_img/classic/
convert buffer\-write.png -negate -channel B -evaluate set $B_mult -channel G -evaluate multiply 1 +channel buffer\-write.png 
