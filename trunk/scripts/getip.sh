echo "$1 : " >> hosts.out
nslookup $1 168.95.1.1|grep Address|grep -v 53 |awk '{print $2}'|xargs -L1 sh ./check.sh |head -n 1 
