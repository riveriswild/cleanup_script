#!/bin/bash
TARGET=$PWD
CSV=cleanup.csv
if [ ! -f ${CSV} ];
 then
     echo "The cleanup.csv file does not exist."
     exit -1
fi
tr -d '\r' < $CSV > temp.csv
mv temp.csv $CSV
while read csvline
do
   count=1
   for filetype in `echo "$csvline" | tr , '\n'`
     do
      if [ $count -eq 1 ];  then
          if [ ! -d $PWD/$filetype ];   then
           mkdir $PWD/$filetype
          fi

        CATEGORY=${filetype}
       else
         mv $PWD/*.${filetype} $PWD/${CATEGORY} 2> /dev/null
      fi
      count=`expr $count + 1`
   done
done < cleanup.csv

