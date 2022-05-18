@echo off
title Windows 11 Android Subsystem Install
mode con: cols=75  lines=15
Rem detecting windows os verion
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.3" echo Current windows version is Windows 8.1
if "%version%" == "6.2" echo Current windows version is Windows 8.
if "%version%" == "6.1" echo Current windows version is Windows 7.
if "%version%" == "6.0" echo Current windows version is Windows Vista.
if "%version%" GEQ "10.0" echo Current windows version is Windows 10.
if "%version%" GEQ "10.0.22000" goto Win11 echo Current windows version is Windows 11.
rem etc etc
endlocal

Rem if windows 11 detected then it will move to Win11

:Win11
echo Current windows version is Win11
echo enabling VirtualPlatform....
DISM /online /get-featureinfo /featurename:virtualPlatform
DISM /online /enable-feature /featurename:virtualPlatform
echo appx packages starting....

set username=%USERNAME%
echo Getting current user name ....
echo Found username %USERNAME%
md "C:\Users\%USERNAME%\Desktop\WSA"
cd C:\Users\%USERNAME%\Desktop\WSA
echo Downloading file from internet please connect to internet
echo Downloading framework package
start chrome.exe http://tlu.dl.delivery.mp.microsoft.com/filestreamingservice/files/d81456bd-ee18-43b1-8257-626d01eb2409?P1=1649703580&P2=404&P3=2&P4=G9bSJN1pzBPjHifX8e55HKwW80mHoAQfwZFUJk%2fO06hOoLZN4TZGhyyiXiXOMwoFlgXPfVd%2beSxkEFkkyKTiLw%3d%3d
"C:\Program Files\7-Zip\7z.exe" e "framework_package.zip" -DestinationPath C:\Users\%USERNAME%\Desktop\WSA
echo Downloading Main_data package
curl "http://tlu.dl.delivery.mp.microsoft.com/filestreamingservice/files/d81456bd-ee18-43b1-8257-626d01eb2409?P1=1648130166&P2=404&P3=2&P4=Y0dG66E73DGDeLKMNqYvyMIfqRZ2MGcywD%2fFmviCF3bqtHao1yBZ5DzeP2h80dr9IjVaVOJC3ivNTqvQjMvDCA%3d%3d" --output main_package.zip
Expand-Archive main_package.zip -DestinationPath C:\Users\%USERNAME%\Desktop\WSA
powershell.exe Add-AppxPackage -Path “C:\Users\%USERNAME%\Desktop\Microsoft.UI.Xaml.2.6_2.62112.3002.0_x64__8wekyb3d8bbwe.Appx"

powershell.exe Add-AppxPackage -Path “C:\Users\%USERNAME%\Desktop\MicrosoftCorporationII.WindowsSubsystemForAndroid_2203.40000.1.0_neutral___8wekyb3d8bbwe.Msixbundle”


pause
