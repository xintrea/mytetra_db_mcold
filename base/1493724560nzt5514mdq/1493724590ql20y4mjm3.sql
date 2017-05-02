--прогонять под SYS*

--отключаем триггера на системные события, чтобы не заломали нам пост скрипт
alter system set "_system_trig_enabled"=false;

-----------------------------------
--      Компиляция пакетов       --
-----------------------------------
exec sys.utl_recomp.recomp_serial;

-----------------------------------
--      Компиляция ролей         --
-----------------------------------

alter session set Current_schema=BTK;
exec AC_COMMONPKG.installAdminRoles;
exec ac.SynchronizeAllServer;

--включаем триггера на системные события
alter system set "_system_trig_enabled"=true;

-----------------------------------
--      Сбор статистики          --
-----------------------------------
exec DBMS_Stats.GATHER_SCHEMA_STATS(ownname => 'BTK', cascade => true);

exit;