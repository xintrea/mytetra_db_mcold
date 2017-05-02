begin
 execute immediate 'alter session set events ''10851 trace name context forever ,level 2''';

 DECLARE
  CURSOR c1 IS SELECT name FROM user_queues;
  CURSOR c2 IS SELECT queue_table FROM user_queue_tables;
BEGIN
  FOR i IN c1 LOOP
    begin
    dbms_aqadm.stop_queue(i.name);
    dbms_aqadm.drop_queue(i.name);
    exception
      when others then
        dbms_output.put_line( sqlerrm );
    end;
  END LOOP;
  FOR j IN c2 LOOP
    begin
    dbms_aqadm.drop_queue_table(j.queue_table);
    exception
      when others then
        dbms_output.put_line( sqlerrm );
    end;
  END LOOP;
END;
 
end;
/
exit;