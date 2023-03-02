@echo off

echo --------------------------------------------------------------------------------------------------------------
echo Disclaimer
echo The author assumes no responsibility for any damages caused by the use of this script.
echo;

echo Usage Notes
echo This script is only supported for the Star Citizen Live version
echo and the default installation location.
echo In addition, since the contents of the folder displayed as the target for deletion will be completely deleted, 
echo please check the displayed target carefully before carrying out the deletion.
echo;

echo author 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo --------------------------------------------------------------------------------------------------------------
echo;

set LIBPATH=C:\Program Files\Roberts Space Industries
set PLYVER=LIVE

set COUNT=0

set USRDIR=dir /a:d /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=dir /a:d /s /b "%STUSRPATH%\StarCitizen\%PLYVER%\USER"*

set SHDDIR=dir /a:d /s /b "%APPDATA%\..\Local\Star Citizen\sc-alpha"*
for %%i in ("%APPDATA%\..\Local\Star Citizen\sc-alpha") do set STSHDPATH=%%~si
set STSHDDIR=dir /a:d /s /b "%STSHDPATH%"*

echo Subjects for deletion include
echo;

echo User folder
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo User folder is missing
  set /a COUNT=%COUNT%+1
)
echo;

echo Shader folder
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo Shader folder is missing
  set /a COUNT=%COUNT%+2
)
echo;

if %COUNT% equ 3 (
  echo The folder to be deleted does not exist, so the process is terminated.
  pause
  EXIT
)

set /P CHK="Are you sure you want to perform the deletion? (y/n)"

if /i {%CHK%}=={y} (goto :continue)
if /i {%CHK%}=={yes} (goto :continue)

echo Deletion process is aborted.
pause
exit

:continue

if %COUNT% neq 1 (
  for /f %%i in ('%STUSRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo Deleted user folder
)

if %COUNT% neq 2 (
  for /f %%i in ('%STSHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo Deleted shader folder
)

pause