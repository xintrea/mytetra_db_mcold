rem Проверить путь к архиватору

rem экспорт полного дампа
echo Export begin		> _Export.bat.log
date /T 				>> _Export.bat.log
time /T 				>> _Export.bat.log
sqlplus "btk/btk@DB1" @_Export.bat.sql 		> Btk.ver
exp "system/sys@DB1" parfile=_Export.bat.par

