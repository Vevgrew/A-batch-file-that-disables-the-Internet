@echo off
setlocal enabledelayedexpansion

for /l %%x in (1,1,2) do (
    for /f "tokens=*" %%A in ('netsh interface show interface') do (
        set "line=%%A"
        echo !line! | findstr /C:"Connected" >nul && call :d "!line!"
        echo !line! | findstr /C:"Подключено" >nul && call :d "!line!"
        echo !line! | findstr /C:"Підключено" >nul && call :d "!line!"
    )
    timeout /t 1 >nul
)

goto :eof

:d
for /f "tokens=1-4*" %%i in ("%~1") do netsh interface set interface "%%l" admin=disable
goto :eof