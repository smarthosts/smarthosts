curl --connect-timeout 5 $1 
if [ $? -eq 28 ]
then
    echo $1 >> badiplist.txt 
fi 

