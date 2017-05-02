--��������� ��� SYS*

--��������� �������� �� ��������� �������, ����� �� �������� ��� ���� ������
alter system set "_system_trig_enabled"=false;

-----------------------------------
--      ���������� �������       --
-----------------------------------
exec sys.utl_recomp.recomp_serial;

-----------------------------------
--      ���������� �����         --
-----------------------------------

alter session set Current_schema=BTK;
exec AC_COMMONPKG.installAdminRoles;
exec ac.SynchronizeAllServer;

--�������� �������� �� ��������� �������
alter system set "_system_trig_enabled"=true;

-----------------------------------
--      ���� ����������          --
-----------------------------------
exec DBMS_Stats.GATHER_SCHEMA_STATS(ownname => 'BTK', cascade => true);

exit;