
cat ../hosts|grep "203.208.4"| awk '{print $2}'|sort|xargs -L1 sh ./getip.sh

