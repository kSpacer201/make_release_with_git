#!/bin/bash

#init part 
release_dir='__release'
tmp_dir='__tmp'
release_tmp="${release_dir}/${tmp_dir}"

clean_tmp_dir() {
    rm -rf ${release_tmp}
}

init_tmp_dir() {
    mkdir -p ${release_tmp}
}

if [ ! -d ".git" ]; then 
    #make release dir
    init_tmp_dir

    #init repo
    git init 

    echo .gitignore>.gitignore
    echo ${release_dir}>>.gitignore
fi

if [ $# == 0 ];then
    echo "#.sh add package[folder/files]  version  comment"
    echo "#.sh get version"
    echo "#.sh get-patch ver-old ver-new"
	exit
fi

#.sh add package[folder/files]  version  comment
#     $1    $2                      $3      $4
if [ $1 = 'add' ];then 
	init_tmp_dir
    #clean tmp
    clean_tmp_dir
    #copy files from source dir
    cp -r "$2" ${release_tmp}
    rm -rf ${release_tmp}/.git
    mv -f ${release_tmp}/* ./
    git add .
    git commit . -m "$4"
    git tag "$3"
fi

#.sh get version 
#     $1   $2
if [ $1 = 'get' ];then
	init_tmp_dir
    git checkout "$2"
fi

#.sh get-patch ver-old ver-new , get a patch-release -> = [new] - [old] 
#     $1        $2     $3
if [ $1 = 'get-patch' ];then
	init_tmp_dir
    update_info_file_name=$release_dir/"update_from_$2_to_$3.txt"
    # update_zip_file_name=$release_dir/"update_from_$2_to_$3.tar.gz"
    git diff $2 $3 --stat> $update_info_file_name
    while read line
	do
        if [[ $line == *file*changed* ]] ; then 
            break
        fi 
		file_name=`echo "${line%|*}"|sed 's/[ ]*$//g'`
        cp --parents ${file_name} ${release_tmp}
	done < ${update_info_file_name}
	pushd ${release_tmp}
	tar -zcvf ../"update_from_$2_to_$3.tar.gz" *
	popd
	clean_tmp_dir
	#restore to master 
	git checkout master
fi
