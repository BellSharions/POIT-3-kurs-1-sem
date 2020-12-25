if [ "$1" == "" ]
then
	echo "parametrs not found"
else
	echo "Name:" $(ps -p $1 -o comm -h)
	echo "Pid:" $1
	echo "PPid:" $(ps -o ppid= -p $1)
fi
if [ "$2" == "fd" ]
then
for x in $(ls -l /proc/$1/fd | awk '{print $9}')
do
	echo "fd="$x
done
fi
