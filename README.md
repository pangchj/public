# LyX dark theme icons

I was searching for dark theme icons to use for LyX. At first I used the suggestion in https://wiki.lyx.org/LyX/Icons and run the command to get a icon theme suitable for the dark theme:

sudo find /usr/share/lyx/images/ -type f -exec convert {} -negate {} ;

This solution works only partially. The "Classic" icon set can be changed to a usable dark theme icon set. But it turns out that under /usr/share/lyx/images/math/, the icons are now in *.svgz format and cannot be changed with the command above. I eventually gained enough knowledge of how to change the colors of the icon set and saved the icon sets.

**To see what the icon set looks like**: See the file LyX_dark_theme.jpg in this directory.

**To use a script file to change the images suitable for a dark theme (In Linux):** Download the files aa_change.sh and aa_subroutine.sh into the same folder. Make the scripts executable in Linux with "chmod +x aa_change.sh" and "chmod +x aa_subroutine.sh". Then run "sudo aa_change.sh".

Make sure that you use the "Classic" icon set in LyX, since only this icon set is inverted.

**To use the images compressed in the zip file (which I hope works for Windows):** Download the file lyx_images.zip. In Ubuntu, replace the folder /usr/share/lyx/images/ ; In another operating system, the image file directory can be found in LyX with Help > About LyX. 

-pangchj
