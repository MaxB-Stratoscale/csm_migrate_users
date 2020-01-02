
#!/usr/bin/bash


#symp -k user list |awk -F "|" '/none/ {print $2,$3}' |while read line
symp -k -u admin -p admin -d cloud_admin user list |awk -F "|" '/none/ {print $1,$2}' |while read line
 do
    
  user_name=$(echo $line|awk '{print $2}')
  user_id=$(echo $line|awk '{print $1}')
    
  if [ $user_id != "admin" ]; then
  grep $user_name  role_user_scope_sorted_userName |grep project |awk -v u=$user_id '{print "symp -k -u admin -p admin -d cloud_admin  project grant-role " $4,  u , $1 }'
  grep $user_name  role_user_scope_sorted_userName |grep domain |awk -v u=$user_id '{print "symp -k -u admin -p admin -d cloud_admin  domain  grant-role " $4,  u , $1 }'
  fi
 done
