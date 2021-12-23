#!/bin/bash

# 将 old_db 数据迁移到 new_db 中
# from: https://stackoverflow.com/questions/67093/how-do-i-quickly-rename-a-mysql-database-change-schema-name
# RENAME TABLE old_db.table TO new_db.table;
# mysql -u username -ppassword old_db -sNe 'show tables' | while read table; \ 
#    do mysql -u username -ppassword -sNe "rename table old_db.$table to new_db.$table"; done
#

old_db=$1
new_db=$2
user=$3
password=$4

for table in `mysql -u ${user} -p${password} -s -N -e "use ${old_db};show tables from ${old_db};"`
do
	mysql -u ${user} -p${password} -s -N -e "use ${old_db};rename table ${old_db}.$table to $new_db.$table;"
done
