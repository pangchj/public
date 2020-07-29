# LyX dark theme icons

I was searching for dark theme icons to use for LyX. At first I used the suggestion in https://wiki.lyx.org/LyX/Icons and run the command to get a icon theme suitable for the dark theme:

sudo find /usr/share/lyx/images/ -type f -exec convert {} -negate {} ;

This solution works only partially. The "Classic" icon set can be changed to a usable dark theme icon set. But it turns out that under /usr/share/lyx/images/math/, the icons are now in *.svgz format and cannot be changed with the command above. I eventually gained enough knowledge of how to change the colors of the icon set and saved the icon sets.

To use: Download the file lyx_images.zip. In Ubuntu, replace the folder /usr/share/lyx/images/ ; In another operating system, the image file directory can be found in LyX with Help > About LyX. 

To do your own amendments: I have included the shell script I ran in Linux to get the icons from the default icon sets. In the folder ./images/math/, I need to do two 'sed' commands. In the folder ./images/ipa/, I needed to do three 'sed' commands. The command I needed to run was aa_change.sh. (See also aa_change2.sh).

I made these admendments in 29 July 2020. 

-pangchj
