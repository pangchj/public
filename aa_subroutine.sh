first_var=$1
shift
for x in $*
do
#echo $first_var $x
sed -e "$first_var" $x > t1$x
mv t1$x $x
done
