DEFINE 1 = BTK
SET VERIFY OFF

-- создание схемы
declare bvExists integer;
begin
  select nvl(max(1),0) into bvExists from dba_users u where upper(u.username) = upper('&1.');
  if bvExists = 0 then 
    execute immediate 'create user &1. identified by btk';
  end if;
end;
/
alter user &1. temporary tablespace temp
/
alter user &1. default tablespace users
/
alter user &1. quota unlimited on usersnew
/
alter user &1. quota unlimited on INDX
/
alter user &1. quota unlimited on ACTNEW
/
alter system set query_rewrite_integrity = TRUSTED
/

-- Grant/Revoke role privileges 
grant connect to &1. with admin option;
grant dba to &1. with admin option;
-- Grant/Revoke system privileges 

-----------------------------------
--   Системные права владельца   --
-----------------------------------

grant ADMINISTER DATABASE TRIGGER    to &1.;
grant ALTER ANY CLUSTER              to &1.;
grant ALTER ANY DIMENSION            to &1.;
grant ALTER ANY INDEX                to &1.;
grant ALTER ANY INDEXTYPE            to &1.;
grant ALTER ANY LIBRARY              to &1.;
grant ALTER ANY OUTLINE              to &1.;
grant ALTER ANY PROCEDURE            to &1.;
grant ALTER ANY ROLE                 to &1.;
grant ALTER ANY SEQUENCE             to &1.;
grant ALTER ANY SNAPSHOT             to &1.;
grant ALTER ANY TABLE                to &1.;
grant ALTER ANY TRIGGER              to &1.;
grant ALTER ANY TYPE                 to &1.;
grant ALTER DATABASE                 to &1.;
grant ALTER PROFILE                  to &1.;
grant ALTER RESOURCE COST            to &1.;
grant ALTER ROLLBACK SEGMENT         to &1.;
grant ALTER SESSION                  to &1.;
grant ALTER SYSTEM                   to &1.;
grant ALTER TABLESPACE               to &1.;
grant ALTER USER                     to &1.;
grant ANALYZE ANY                    to &1.;
grant AUDIT ANY                      to &1.;
grant AUDIT SYSTEM                   to &1.;
grant BACKUP ANY TABLE               to &1.;
grant BECOME USER                    to &1.;
grant COMMENT ANY TABLE              to &1.;
grant CREATE ANY  CONTEXT            to &1.;
grant CREATE ANY CLUSTER             to &1.;
grant CREATE ANY CONTEXT             to &1.;
grant CREATE ANY DIMENSION           to &1.;
grant CREATE ANY DIRECTORY           to &1.;
grant CREATE ANY INDEX               to &1.;
grant CREATE ANY INDEXTYPE           to &1.;
grant CREATE ANY LIBRARY             to &1.;
grant CREATE ANY OPERATOR            to &1.;
grant CREATE ANY OUTLINE             to &1.;
grant CREATE ANY PROCEDURE           to &1.;
grant CREATE ANY SEQUENCE            to &1.;
grant CREATE ANY SNAPSHOT            to &1.;
grant CREATE ANY SYNONYM             to &1.;
grant CREATE ANY TABLE               to &1.;
grant CREATE ANY TRIGGER             to &1.;
grant CREATE ANY TYPE                to &1.;
grant CREATE ANY VIEW                to &1.;
grant CREATE CLUSTER                 to &1.;
grant CREATE DATABASE LINK           to &1.;
grant CREATE DIMENSION               to &1.;
grant CREATE INDEXTYPE               to &1.;
grant CREATE LIBRARY                 to &1.;
grant CREATE OPERATOR                to &1.;
grant CREATE PROCEDURE               to &1.;
grant CREATE PROFILE                 to &1.;
grant CREATE PUBLIC DATABASE LINK    to &1.;
grant CREATE PUBLIC SYNONYM          to &1.;
grant CREATE ROLE                    to &1.;
grant CREATE ROLLBACK SEGMENT        to &1.;
grant CREATE SEQUENCE                to &1.;
grant CREATE SESSION                 to &1.;
grant CREATE SNAPSHOT                to &1.;
grant CREATE SYNONYM                 to &1.;
grant CREATE TABLE                   to &1.;
grant CREATE TABLESPACE              to &1.;
grant CREATE TRIGGER                 to &1.;
grant CREATE TYPE                    to &1.;
grant CREATE USER                    to &1.;
grant CREATE VIEW                    to &1.;
grant DEBUG ANY PROCEDURE            to &1.;
grant DEBUG CONNECT SESSION          to &1.;
grant DELETE ANY TABLE               to &1.;
grant DROP ANY  CONTEXT              to &1.;
grant DROP ANY CLUSTER               to &1.;
grant DROP ANY CONTEXT               to &1.;
grant DROP ANY DIMENSION             to &1.;
grant DROP ANY DIRECTORY             to &1.;
grant DROP ANY INDEX                 to &1.;
grant DROP ANY INDEXTYPE             to &1.;
grant DROP ANY LIBRARY               to &1.;
grant DROP ANY OPERATOR              to &1.;
grant DROP ANY OUTLINE               to &1.;
grant DROP ANY PROCEDURE             to &1.;
grant DROP ANY ROLE                  to &1.;
grant DROP ANY SEQUENCE              to &1.;
grant DROP ANY SNAPSHOT              to &1.;
grant DROP ANY SYNONYM               to &1.;
grant DROP ANY TABLE                 to &1.;
grant DROP ANY TRIGGER               to &1.;
grant DROP ANY TYPE                  to &1.;
grant DROP ANY VIEW                  to &1.;
grant DROP PROFILE                   to &1.;
grant DROP PUBLIC DATABASE LINK      to &1.;
grant DROP PUBLIC SYNONYM            to &1.;
grant DROP ROLLBACK SEGMENT          to &1.;
grant DROP TABLESPACE                to &1.;
grant DROP USER                      to &1.;
grant EXECUTE ANY INDEXTYPE          to &1.;
grant EXECUTE ANY LIBRARY            to &1.;
grant EXECUTE ANY OPERATOR           to &1.;
grant EXECUTE ANY PROCEDURE          to &1.;
grant EXECUTE ANY TYPE               to &1.;
grant FLASHBACK ANY TABLE            to &1.;
grant FORCE ANY TRANSACTION          to &1.;
grant FORCE TRANSACTION              to &1.;
grant GLOBAL QUERY REWRITE           to &1.;
grant GRANT ANY OBJECT PRIVILEGE     to &1.;
grant GRANT ANY PRIVILEGE            to &1.;
grant GRANT ANY ROLE                 to &1.;
grant INSERT ANY TABLE               to &1.;
grant LOCK ANY TABLE                 to &1.;
grant MANAGE TABLESPACE              to &1.;
grant ON COMMIT REFRESH              to &1.;
grant QUERY REWRITE                  to &1.;
grant RESTRICTED SESSION             to &1.;
grant RESUMABLE                      to &1.;
grant SELECT ANY SEQUENCE            to &1.;
grant SELECT ANY TABLE               to &1.;
grant UNDER ANY TABLE                to &1.;
grant UNDER ANY TYPE                 to &1.;
grant UNDER ANY VIEW                 to &1.;
grant UNLIMITED TABLESPACE           to &1.;
grant UPDATE ANY TABLE               to &1.;
GRANT SELECT ANY DICTIONARY          to &1.; 

-----------------------------------
--   Объектные права владельца   --
-----------------------------------

grant ALTER      on SYS.DEPENDENCY$     to &1.;
grant ALTER      on SYS.SOURCE$         to &1.;
grant DELETE     on SYS.DEPENDENCY$     to &1.;
grant DELETE     on SYS.SOURCE$         to &1.;
grant EXECUTE    on SYS.DBMS_ALERT      to &1.;
grant EXECUTE    on SYS.DBMS_AQ         to &1. with grant option;
grant EXECUTE    on SYS.DBMS_AQADM      to &1.;
grant EXECUTE    on SYS.DBMS_FLASHBACK  to &1.;
grant EXECUTE    on SYS.DBMS_JAVA       to &1. with grant option;
grant EXECUTE    on sys.DBMS_LOCK       to &1.;
grant EXECUTE    on SYS.DBMS_PIPE       to &1.;
grant EXECUTE    on SYS.DBMS_RLS        to &1.;
grant EXECUTE    on SYS.DBMS_SESSION    to &1.;
grant EXECUTE    on sys.utl_recomp      to &1.;
grant INDEX      on SYS.DEPENDENCY$     to &1.;
grant INDEX      on SYS.SOURCE$         to &1.;
grant INSERT     on SYS.DEPENDENCY$     to &1.;
grant INSERT     on SYS.SOURCE$         to &1.;
grant REFERENCES on SYS.DEPENDENCY$     to &1.;
grant REFERENCES on SYS.SOURCE$         to &1.;
grant select     on dba_context         to &1.;
grant select     on dba_java_policy     to &1. with grant option;
grant select     on dba_mviews          to &1.;
grant select     on sys.attrcol$        to &1.;
grant select     on sys.ccol$           to &1.;
grant select     on sys.cdef$           to &1.;
grant SELECT     on SYS.COL$            to &1. with grant option;
grant SELECT     on SYS.COLTYPE$        to &1. with grant option;
grant select     on sys.con$            to &1.;
grant SELECT     on SYS.DBA_COL_PRIVS   to &1. with grant option;
grant select     on sys.dba_jobs        to &1. with grant option;
grant SELECT     on SYS.DBA_OBJECTS     to &1. with grant option;
grant SELECT     on SYS.DBA_ROLE_PRIVS  to &1. with grant option;
grant SELECT     on SYS.DBA_ROLES       to &1.  with grant option;
grant SELECT     on SYS.DBA_SYS_PRIVS   to &1. with grant option;
grant SELECT     on SYS.DBA_TAB_COLS    to &1. with grant option;
grant SELECT     on SYS.DBA_TAB_PRIVS   to &1. with grant option;
grant SELECT     on SYS.DBA_USERS       to &1. with grant option;
grant SELECT     on sys.DBMS_LOCK_ALLOCATED to &1.;
grant SELECT     on SYS.DEPENDENCY$     to &1. with grant option;
grant SELECT     on SYS.KU$_COLUMN_VIEW to &1.;
grant select     on sys.link$           to &1. with grant option;
grant SELECT     on SYS.OBJ$            to &1. with grant option;
grant SELECT     on SYS.SOURCE$         to &1. with grant option;
grant SELECT     on SYS.TAB$            to &1. with grant option;
grant SELECT     on SYS.USER$           to &1. with grant option;
grant SELECT     on SYS.v_$database     to &1. with grant option;
grant SELECT     on SYS.v_$instance     to &1. with grant option;
grant SELECT     on SYS.v_$lock         to &1. with grant option;
grant SELECT     on SYS.V_$PARAMETER    to &1. with grant option;
grant SELECT     on SYS.v_$session      to &1. with grant option;
grant UPDATE     on SYS.DEPENDENCY$     to &1.;
grant UPDATE     on SYS.SOURCE$         to &1.;

grant select     on sys.v_$open_cursor to &1.;
grant select     on sys.v_$sqltext_with_newlines  to &1.;
grant select     on sys.v_$sesstat to &1.;
grant select     on sys.v_$statname to &1.;
grant select     on sys.DBA_JOBS_RUNNING to &1.;
grant select     on sys.V_$MYSTAT to &1.;
grant select     on sys.v_$active_session_history to &1.;

grant select on sys.GV_$LOCK to &1. with grant option;
grant select on sys.GV_$SESSION to &1. with grant option;
grant select on sys.gv_$active_session_history to &1.;
grant select on sys.gv_$myStat to &1.;
grant select on sys.gv_$transaction to &1.;

grant select on sys.dba_ddl_locks to &1. with grant option;
grant select on sys.gv_$database to &1. with grant option;
grant select on sys.dba_scheduler_running_jobs to &1. with grant option;


--Прова для работы с oracle text
grant CTXAPP  to &1.;
GRANT EXECUTE ON CTXSYS.CTX_CLS to &1.;
GRANT EXECUTE ON CTXSYS.CTX_DDL to &1.;
GRANT EXECUTE ON CTXSYS.CTX_DOC to &1.;
GRANT EXECUTE ON CTXSYS.CTX_OUTPUT to &1.;
GRANT EXECUTE ON CTXSYS.CTX_QUERY to &1.;
GRANT EXECUTE ON CTXSYS.CTX_REPORT to &1.;
GRANT EXECUTE ON CTXSYS.CTX_THES to &1.;
GRANT EXECUTE ON CTXSYS.CTX_ULEXER to &1.;



-- Создание представления. Выбираем из library cache данные об активных курсорах, созданных хранимыми процедурами
create or replace view btk_active_ddl_lock as
select ob.kglnaobj 			as sObjectName
     , decode(ob.kglhdpmd, 2, 1, 0) 	as bIsActive
from x$kglob ob 
where ob.kglhdnsp = 1 -- Признак хранимой процедуры
/
-- Права 
grant SELECT	 on SYS.BTK_Active_DDL_Lock to &1; 

--быстрый запрос текста sql по sql_id
create or replace view btk_sql_text as
select t.kglnaobj sql_text
      ,t.kglfnobj sql_text_full
      ,t.kglobt03 sql_id
  from sys.X$KGLOB t
/
grant SELECT	 on SYS.btk_sql_text to &1; 


create or replace view btk_libcachepin as
select decode(lob.kglobtyp, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
                       4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
                       7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
                       11, 'PACKAGE BODY', 12, 'TRIGGER',
                       13, 'TYPE', 14, 'TYPE BODY',
                       19, 'TABLE PARTITION', 20, 'INDEX PARTITION', 21, 'LOB',
                       22, 'LIBRARY', 23, 'DIRECTORY', 24, 'QUEUE',
                       28, 'JAVA SOURCE', 29, 'JAVA CLASS', 30, 'JAVA RESOURCE',
                       32, 'INDEXTYPE', 33, 'OPERATOR',
                       34, 'TABLE SUBPARTITION', 35, 'INDEX SUBPARTITION',
                       40, 'LOB PARTITION', 41, 'LOB SUBPARTITION',
                       42, 'MATERIALIZED VIEW',
                       43, 'DIMENSION',
                       44, 'CONTEXT', 46, 'RULE SET', 47, 'RESOURCE PLAN',
                       48, 'CONSUMER GROUP',
                       51, 'SUBSCRIPTION', 52, 'LOCATION',
                       55, 'XML SCHEMA', 56, 'JAVA DATA',
                       57, 'SECURITY PROFILE', 59, 'RULE',
                       62, 'EVALUATION CONTEXT',
                      'UNDEFINED') object_type
        ,lob.KGLNAOBJ object_name
        ,pn.KGLPNMOD lock_mode_held
        ,pn.KGLPNREQ lock_mode_requested
        ,pn.KGLPNUSE
        ,lob.KGLHDADR
        ,lob.KGLHDPAR
   from x$kglpn pn
       ,x$kglob lob
  where /*pn.KGLPNUSE(+) = '0000007AA3726408'
    and */pn.KGLPNHDL(+) = lob.KGLHDADR
--    and lob.kglhdadr = '0000007A3EECAC20'
  order by lock_mode_held desc
/

grant SELECT	 on sys.btk_libcachepin to &1; 



create or replace view btk_sql_bind as
select t.KQLFBC_cadd child_address
      ,t.KQLFBC_sqlid sql_id
      ,t.KQLFBC_name name
      ,t.KQLFBC_strval strval
  from X$KQLFBC t
/

grant SELECT	 on sys.btk_sql_bind to &1; 


-- предоставление права на экспорт и импорт
grant imp_full_database to &1;
grant exp_full_database to &1;


-----------------------------------
--     Создание пользователей    --
-----------------------------------

declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_users u where upper(u.username) = 'GUEST';
  if bvExists = 0 then 
    execute immediate 'create user GUEST identified by GUEST';
  end if;
end;
/
alter user GUEST temporary tablespace temp
/
alter user GUEST default tablespace users
/


-----------------------------------
--      Контекст для клиента     --
-----------------------------------

create or replace context BTKApplicationContext using sys.DBMS_SESSION;


-----------------------------------
--        Создание ролей         --
-----------------------------------


-- Создание роли DEVELOPER  --
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_roles r where upper(r.role) = 'DEVELOPER';
  if bvExists = 0 then 
    execute immediate 'create role DEVELOPER';
  end if;
end;
/
-- Системные права роли DEVELOPER

  grant DELETE ANY TABLE      to DEVELOPER;
  grant EXECUTE ANY TYPE      to DEVELOPER;
  grant INSERT ANY TABLE      to DEVELOPER;
  grant SELECT ANY TABLE      to DEVELOPER;
  grant UPDATE ANY TABLE      to DEVELOPER;
  grant EXECUTE ANY PROCEDURE to DEVELOPER;


-- Объектные права роли DEVELOPER



-- Создание роли GSUSER  --
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_roles r where upper(r.role) = 'GSUSER';
  if bvExists = 0 then 
    execute immediate 'create role GSUSER';
  end if;
end;
/

-- Создание роли CONNECT  --
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_roles r where upper(r.role) = 'CONNECT';
  if bvExists = 0 then 
    execute immediate 'create role CONNECT';
  end if;
end;
/

-- Системные права роли CONNECT
grant create session to CONNECT;


-- Создание роли GSConnect  --
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_roles r where upper(r.role) = upper('GSConnect');
  if bvExists = 0 then 
    execute immediate 'create role GSConnect';
  end if;
end;
/

-- Системные права роли GSConnect


-- Объектные права роли GSConnect
grant EXECUTE on RPT to GSConnect;
grant EXECUTE on BTK_FILTERAPI to GSConnect;
grant EXECUTE on BTK_DATABOUNDSAPI to GSConnect;
grant SELECT  on BTK_DATABOUNDSGTT to GSConnect;
grant INSERT  on BTK_DATABOUNDSGTT to GSConnect;
grant DELETE  on BTK_DATABOUNDSGTT to GSConnect;

-- Присоединяем GsUser к GSConnect
grant GsUser to GSConnect;

-- Присоединяем Guest к GsConnect
grant GSConnect to Guest;


-- Создание роли ACUSER  --
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists from dba_roles r where upper(r.role) = 'ACUSER';
  if bvExists = 0 then 
    execute immediate 'create role ACUSER';
  end if;
end;
/

-- Системные права роли ACUSER

-- Объектные права роли ACUSER

-- Присоединяем Guest к ACUSER
declare 
  bvExists   number;
begin
  select nvl(max(1),0) into bvExists 
  from sys.dba_role_privs r 
  where upper(r.granted_role) = upper('ACUSER') 
    and upper(r.grantee) != upper('SYS')
    and upper(r.grantee) != upper('GUEST');
  if bvExists = 0 then 
    execute immediate 'grant ACUser to Guest';
  end if;
end;
/




grant select on sys.dbms_lock_allocated to ACuser;

grant select on V_$LOCK to ACuser;

grant select on V_$SESSION to ACuser;

grant execute on dbms_crypto to &1.;

--фича для 12 оракла, чтобы работали вызовы пакетов с authid current_user
--нужен для пост скрипта
grant INHERIT PRIVILEGES ON USER SYS TO BTK;

exit;