echo "#Author: liruqi@gmail.com"
echo "#Date: `date`"
echo "#Description: generate dnsmasq conf from hosts file\n"

echo $(cat <<EOF
server=/android.clients.google.com/114.114.114.114
server=/top100.cn/114.114.114.114
server=/mtalk.google.com/8.8.4.4
server=/talk.google.com/8.8.4.4
server=/reader.googleusercontent.com/8.8.4.4
#tumblr
alias=174.121.98.156,66.6.32.137 
alias=50.22.53.157,66.6.32.137 
alias=50.22.53.155,66.6.32.137 
alias=72.32.231.8,66.6.32.137
alias=174.121.66.230,66.6.32.137
alias=174.121.194.34,66.6.32.137
#dropbox
alias=107.20.170.126,204.236.224.226
alias=174.129.199.91,204.236.224.226
EOF
) | awk 'BEGIN { RS = " " } ; { print $0 }'
cat hosts| egrep -v "^#|^$|localhost|0\.0\.0\.0|wiki|googleusercontent"|awk '{print "address=/"$2"/"$1; }'


