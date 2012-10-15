cat ../hosts| egrep -v "^#|^$|localhost|0\.0\.0\.0"|awk '{print $1; }'|sort --un | xargs -L 1 sh check.sh 

