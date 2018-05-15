# make_release_with_git
easy tool to make package or modified files to a tar.gz package for softwares 
# prerequests
 - git
 - tar
 - sh 
 - rm 
 - cp 
 - mv
# how to use
 on windows ,just use **cmder** and run `sh make_release_with_git.sh *`, '*' claims you input args
 - go to the git-repo dir
 - Test OK
   - make a patch package 
     - ```
       make_release_with_git.sh get-patch your-file-path ver01 ver02
       ```
     - then find your package in dir -> __release
 - TODO
   - add new version software files
     - ```
       make_release_with_git.sh add your-file-path ver01 "this is the new version"
       ```
   - make a version package
     - ```
       make_release_with_git.sh get your-version
       ```
  
