#!/bin/bash

#TODO: If sth failed -> write to logs

backups=$PWD/backups
DATE=$(date +%Y-%m-%d)
apick(){
echo "Menu 1"
echo "Path of the directory: "
read backup_files
echo "We will do a backup of directory $backup_files."
read -p "Do you want to proceed(y/n)?" yn
#t=0
while true; do

	#create the directory with mkdir where backup is safed
	#move to this directory cd $dest if not working

	if [ ! -d $backups ]; then
		mkdir -p $backups
	fi
	archive_file="$backups/backup-$DATE.tgz"
        case $yn in
        y|Y)
	echo "Backing up $backup_files to $dest"
	date

	#tar for backup with -c(createArchive) -v(verbose) -f(useFileArchive)
	tar -cvf ${archive_file} $backup_files

	#TODO: check if backup was succesful (maybe with $?)
	#if not write to logs <<
	echo "Backup finished"
	date
	sleep 4;break;;
	n|N)
        sleep 1;break;;
	*) echo "Please answer yes or no!";break;;
	esac
done

}

bpick()
{
echo "Menu 2"
echo "Path of the directory: "
read dir_files
echo "Minute of backup"
read min
echo "Hour of backup"
read hour

echo "We will do a backup of directory $dir_files at $hour:$min."
read -p "Do you want to proceed(y/n)?" yn

if [ $yn = 'y' ] ; then

   	crontab -l >temp
   	echo "$min $hour * * * bash $PWD/crontask.sh $dir_files $PWD/backups" >>temp
   	crontab temp
else
    sleep 2
fi
}

cpick()
{
echo "Menu 3"
echo "The list of existing backups is:"
#listing content of PWD/backups
list=$(ls $backups/*.tgz)
if [ "$list" != "" ]; then
  echo $list
  echo -ne "Which one do you want to recover?\n"
  read bckfile
    
  tar -zxvf $bckfile
else
	echo "This backup does not exist!"
fi
}


x=0
while [ $x = 0 ]
do
	#clear

echo "ASO 2017-2018"
echo "Sebastian Sauerer"

echo "Backup tool for directories"
echo "---------------------------"

echo "a. Immidiate Backup"
echo "b. Program Backup with cron"
echo "c. Restore the content of a backup"
echo "x. Exit"

read answer

case $answer in
	a|A)
	apick
	sleep 2
	;;
	b|B)
	bpick
	sleep 2
	;;
	c|C)
	cpick
	sleep 2
	;;
	x|X)
  	exit;;
	*)
	clear
	echo "Not an option"
	sleep 1
	;;
esac
done
