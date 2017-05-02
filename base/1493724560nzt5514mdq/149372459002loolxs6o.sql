-- удаление данных старой схемы
begin
 execute immediate 'alter session set events ''10851 trace name context forever ,level 2''';

end;
/
Drop user BTK cascade;
exit;