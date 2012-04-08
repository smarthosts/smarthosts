echo "#Author: liruqi@gmail.com"
echo "#Date: `date`"
echo "#Description: generate dnsmasq conf from hosts file"
cat hosts| egrep -v "^#|^$|localhost|0\.0\.0\.0|wiki|googleusercontent"|awk '{print "address=/"$2"/"$1; }'

echo $(cat <<EOF

#tumblr
alias=174.121.98.156,174.121.194.34 
alias=50.22.53.157,174.121.194.34 
alias=50.22.53.155,174.121.194.34 
alias=72.32.231.8,174.121.194.34
alias=174.121.66.230,174.121.194.34
#dropbox
alias=107.20.170.126,204.236.224.226
alias=174.129.199.91,204.236.224.226
EOF
) | awk 'BEGIN { RS = " " } ; { print $0 }'
