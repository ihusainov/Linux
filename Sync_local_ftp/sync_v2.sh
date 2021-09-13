#!/bin/bash
################
# Script Download and Upload files from local directory export and import
#################
LOG='/tmp/sftp.log'

echo "----------- Send -----------" >> $LOG
echo -e "`date`" >> $LOG

# Отправка файлов "Send files"
lftp -c 'set sftp:connect-program "ssh -a -x -i /home/username/.ssh/private_key.ppk"; connect sftp://username:@sftp.server.ru:2222; >> $LOG; mirror -c -R -L -vvv --Remove-source-files /opt/sftp/prod/export/ UPLOAD >> $LOG' >> $LOG;

echo "----------- Receive -----------" >> $LOG
echo -e "`date`" >> $LOG

# Получение файлов "Receive files"
lftp -c 'set sftp:connect-program "ssh -a -x -i /home/username/.ssh/private_key.ppk"; connect sftp://username:@sftp.server.ru:2222; >> $LOG; mirror -c -L -vvv --Remove-source-files /DOWNLOAD/ /opt/sftp/prod/import >> $LOG; rm -f /DOWNLOAD/*' >> $LOG
