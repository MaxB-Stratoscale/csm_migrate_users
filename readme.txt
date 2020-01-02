On the source cluster run:

mkdir move
cd move
tar -zxvf copy_users.tar.gz 
cd scripts

symp -k user list > user_list
symp -k domain list > dom_list
symp -k project list >  proj_list

edit the prep_role_user_scope script and put the admin password in place 
execute the prep_role_user_scope script:
./prep_role_user_scope > role_user_scope_sorted_userName 


cd ../
tar -zcvf move.tar.gz scripts

On the target cluster run:

mkdir target
cd target
tar -zxf move.tar.gz
cd scripts

execute the two commands below but make sure the admin password is correct:

cat dom_list |grep -v cloud_admin |awk  -F "|" '/True/  {print "symp -k -u admin -p admin -d cloud_admin domain create --description ", "\"" $5 "\"","--custom-domain-id " $2 $3}'  > 1_create_domains.sh
cat proj_list |grep -v cloud_admin |awk -F "|" '/False/ {print "symp -k -u admin -p admin -d cloud_admin  project create --domain-id " $7 " --description " "\"" $9 "\"" " --custom-project-id " $2, "\"" $3 "\""}' > 2_create_projects.sh


1_create_domains.sh
2_create_projects.sh
3_create_users > create_users.sh  # inspect the content of the "create_users.sh" remove the users that should not be created and execute the script
4_ass_role.sh > exec_ass_role.sh  
exec_ass_role.sh
5
