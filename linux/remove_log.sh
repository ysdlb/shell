#!/bin/bash
# reference: https://stackoverflow.com/questions/5908919/shell-script-to-delete-files-when-disk-is-full

DIR=/var/log/tomcat
CAPACITY_LIMIT=10
LOG_FILE_FORMAT=*.log*
# remaining up-to-date log file number won't be delete
REMAINING_FILE_NUM=4
# this shell script log file, where the script execute, where the log write in
RECORD_FILE=remove_log.log

log() {
	echo "[`date "+%Y.%m.%d %H:%M:%S %Z"`] [$(hostname)] [$(whoami)]-> $1"
}


remove_log() {
	if ! cd ${DIR}; then
		echo "ERROR: unable to chdir to directory '$DIR'"
		exit 2
	fi

	if [ ${CAPACITY_LIMIT} == "" ]; then
		CAPACITY_LIMIT=80
	fi

	CAPACITY=$(df -k . | tail -1 | awk '{gsub("%",""); capacity=$5}; END {print capacity}')
	log "disk capacity now is ${CAPACITY}"

	if [ ${CAPACITY} -le ${CAPACITY_LIMIT} ]; then
		log "The disk occupancy is ${CAPACITY}, it's security, so do nothing"
		exit 1
	fi

	log "The disk occupancy is ${CAPACITY}% greater than limit ${CAPACITY_LIMIT}%, some files will be delete"

	FILES=$(ls -rt ${LOG_FILE_FORMAT} | grep -v ${RECORD_FILE})
	FILES_NUMBER=$(echo "${FILES}" | wc -l)
	log "The number of log file is ${FILES_NUMBER}"
	if [ ${FILES_NUMBER} -le ${REMAINING_FILE_NUM} ]; then
		log "There are not enough files left, so do nothing"
		exit 1
	fi

	DEL_NUM=$((${FILES_NUMBER} - ${REMAINING_FILE_NUM}))
	log "At most ${DEL_NUM} files will be removed"

	count=0
	for del_file in ${FILES}; do
		if [ -f ${del_file} ]; then
			((count++))
			[ $count -le ${DEL_NUM} ] || break

			CAPACITY=$(df -k . | tail -1 | awk '{gsub("%",""); capacity=$5}; END {print capacity}')
			[ ${CAPACITY} -gt ${CAPACITY_LIMIT} ] || break

			log "DELETE ${del_file}"
			rm ${del_file}
		fi
	done

	CAPACITY_DEL=$(df -k . | tail -1 | awk '{gsub("%",""); capacity=$5}; END {print capacity}')
	log "After delte files, disk capacity is ${CAPACITY_DEL}"
}

remove_log >> ${RECORD_FILE} 2>&1
