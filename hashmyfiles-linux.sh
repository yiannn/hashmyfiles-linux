#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

read -p "Input folder location(full path):" -r location
read -p "extension of files to hash. To hash every file in folder,leave empty.:" -r extension

printf "Choose hash function to execute.\n1->md5\n2->sha1\n3->sha256\n12->md5+sha1\n13->md5+sha256\n23->sha1+sha256\n123->md5+sha1+sha256\n" 
read -p "Choise:" -r fun

tmp="*.${extension}";
if [ -z "$extension" ]
then
	tmp="*";
fi

if [ $fun -eq 1 ]
then
	printf "MD5" > hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		md5sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 2 ]
then
	printf "SHA1" > hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		sha1sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 3 ]
then
	printf "SHA256" > hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		sha256sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 12 ]
then
	printf "MD5" > hashes.csv && printf "," >> hashes.csv && printf "SHA1" >> hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		md5sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && sha1sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 13 ]
then
	printf "MD5" > hashes.csv && printf "," >> hashes.csv && printf "SHA256" >> hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		md5sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && sha256sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 23 ]
then
	printf "SHA1" > hashes.csv && printf "," >> hashes.csv&& printf "SHA256" >> hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		sha1sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && sha256sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
elif [ $fun -eq 123 ]
then
	printf "MD5" > hashes.csv && printf "," >> hashes.csv && printf "SHA1" >> hashes.csv && printf "," >> hashes.csv && printf "SHA256" >> hashes.csv && printf ","  >> hashes.csv && printf "LOCATION/FILENAME"  >> hashes.csv && printf "\n" >> hashes.csv
	for p in $(find $location -type f -name "$tmp");
       	do
		md5sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && sha1sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && sha256sum $p | awk '{printf $1}' >> hashes.csv && printf ","  >> hashes.csv && readlink -f $p >> hashes.csv ;
	done
	else
	printf "Invalid choise"
fi

IFS="$OIFS"
exit 1
