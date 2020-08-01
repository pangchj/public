for x in $*
do
sed -e "s/<path/<path\ fill='#ffff00'\ /g" $x > temp$x
mv temp$x $x
sed -e "s/#000000/#ffff00/g" $x > temp$x
mv temp$x $x
sed -e "s/fill:black/fill:yellow/g" $x > temp$x
mv temp$x $x
done
