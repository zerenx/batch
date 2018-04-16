@echo off

:init_vars
set DEFAULT_SEARCH_KEYWORD="HID"

:set_tmpfile
set TMPFILE=%TMP%\wakearmed_list_%RANDOM%.txt
echo Temporary file set to : %TMPFILE%
echo.
if exist %TMPFILE% goto :set_tmpfile

:main_func
echo BEFORE :
powercfg -devicequery wake_armed
echo.

set /p SEARCH_KEYWORD=Enter device keyword to disable [HID] : 
if [%SEARCH_KEYWORD%]==[] set SEARCH_KEYWORD=%DEFAULT_SEARCH_KEYWORD%
echo Disabling devices with the keyword : %SEARCH_KEYWORD%
powercfg -devicequery wake_armed | findstr /i %SEARCH_KEYWORD% > %TMPFILE%
for /F "tokens=*" %%i in (%TMPFILE%) do powercfg -devicedisablewake "%%i"
echo.

echo AFTER :
powercfg -devicequery wake_armed
echo.

:cleanup
echo Deleting temporary file : %TMPFILE%
echo.
del %TMPFILE%

:end
pause