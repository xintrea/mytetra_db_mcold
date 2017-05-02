#!/bin/bash
[ "$(whoami)" != 'oracle' ] && ( echo скрипт необходимо запускать из-под пользователя oracle; exit 3 ) # проверка пользователя

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Variables
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
SERVERNAME=`/bin/hostname`;export SERVERNAME
SERVERNAME="$(tr "[:upper:]" "[:lower:]" <<< "$SERVERNAME")"
VLOG=/opt/oracle/admin/imp.sh.log;export VLOG
NLS_LANG=AMERICAN_AMERICA.CL8MSWIN1251;export NLS_LANG
ORACLE_HOME=/opt/oracle/product/11gR1/db;export ORACLE_HOME

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Functions
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
impdump()
{
DB=$1;export DB
BTK=$2;export BTK
SYS=$3;export SYS
FILEDMP=$4;export FILEDMP
# переходим в рабочий каталог, где будет лежать dpdump
cd /opt/oracle/admin/$DB/dpdump

echo ========================================================= >> $VLOG
echo "`date +%d`.`date +%m`.`date +%Y` import" "$SERVERNAME"_"$DB" >> $VLOG
echo ========================================================= >> $VLOG
# перезагрузка базы
env ORACLE_SID=$DB /opt/oracle/product/11gR1/db/bin/sqlplus "$SYS as sysdba" @/opt/oracle/admin/restart.sql > "$SERVERNAME"_"$DB"_restart.log
echo "`date +%T`,`date +%N` start drop user" >> $VLOG
# удаление очереди заданий
/opt/oracle/product/11gR1/db/bin/sqlplus $BTK@$DB @/opt/oracle/admin/dropAQ.sql > "$SERVERNAME"_"$DB"_dropAQ.log
# перезагрузка базы
env ORACLE_SID=$DB /opt/oracle/product/11gR1/db/bin/sqlplus "$SYS as sysdba" @/opt/oracle/admin/restart.sql > "$SERVERNAME"_"$DB"_restart.log
# дроп базы
/opt/oracle/product/11gR1/db/bin/sqlplus "$SYS@$DB as sysdba" @/opt/oracle/admin/drop.sql > "$SERVERNAME"_"$DB"_drop.log

echo "`date +%T`,`date +%N` start pre_script" >> $VLOG

/opt/oracle/product/11gR1/db/bin/sqlplus "$SYS@$DB as sysdba" @/opt/oracle/admin/pre_script.sql > "$SERVERNAME"_"$DB"_pre_script.log

echo "`date +%T`,`date +%N` start importing base" >> $VLOG
/opt/oracle/product/11gR1/db/bin/impdp system/sys@$DB directory=DATA_PUMP_DIR dumpfile="$FILEDMP"

echo "`date +%T`,`date +%N` start post_script" >> $VLOG
/opt/oracle/product/11gR1/db/bin/sqlplus "$SYS@$DB as sysdba" @/opt/oracle/admin/post_script.sql > "$SERVERNAME"_"$DB"_post_script.log

echo "`date +%T`,`date +%N` finished" >> $VLOG
}

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Import dumps
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

impdump 'db01' 'btk/btk' 'sys/sys' 'global.dmp'