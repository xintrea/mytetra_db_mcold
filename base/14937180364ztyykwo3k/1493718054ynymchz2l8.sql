-- вывести текущие версии модулей
SET HEADING OFF;
Select t.sRelease From btk_systemver t  Order By 1;
SET HEADING ON;
-- выход
exit;
