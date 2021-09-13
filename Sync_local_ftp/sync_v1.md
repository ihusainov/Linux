**First solution**

Install lftp
```
	sudo apt-get install lftp 
```
after that create script
```
	#!/bin/bash HOST='mysite.com' USER='myuser' PASS='myuser' TARGETFOLDER='/new' SOURCEFOLDER='/home/myuser/backups'  lftp -f " open $HOST user $USER $PASS lcd $SOURCEFOLDER mirror --reverse --delete --verbose $SOURCEFOLDER $TARGETFOLDER bye " 
```
Save it on some place with name upload.sh. Give it +x permission.
```
	sudo chmod +x /path_to_script/upload.sh 
```
Setup crontab to run this command on every x period of time

For editing crontab run
```
	crontab -e 
```
For running command on every 5 min code is
```
	 */5 * * * * /path_to_script/upload.sh  > /dev/null 2>&1 
```
on every hour
```
	 0 */1 * * * /path_to_script/upload.sh  > /dev/null 2>&1 
```
to run on 4 am
```
	 0 4 * * * /path_to_script/upload.sh  > /dev/null 2>&1 
```
**Solution two**

Create a small and easy script called lftp-script that LFTP can read:
```
	open ftp://username:password@website.com mirror -v --only-newer /home/local/path/ /website.com/public_html/ 
```
Finally you can run LFTP and start the synchronisation. Set crontab like I write but put command
```
	lftp -f /path/to/lftp-script 
```
something like this
```
	 */5 * * * * lftp -f /path/to/lftp-script  > /dev/null 2>&1 
```
**Solution three**

Install curlftpfs
```
	sudo apt-get install curlftpfs 
```
you need to do in order to mount ftp locally is to to run these commands create dir witch will be sync-ed
```
	mkdir hostr 
```
mount remote ftp dir to local
```
	sudo curlftpfs -o allow_other ftp://user:pass@ftp.example.com host 
```
user:pass is the username and password to log into ftp account.

You can add curlftpfs to fstab for automatic mounting by using this line :
```
	curlftpfs#user:pass@ftp.example.com /mnt/host fuse rw,uid=500,user,noauto 0 0 
```
