@ECHO off

REM 環境設定
SET SVN_EXE="C:\Program Files\TortoiseSVN\bin\svn.exe"
SET BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"

SET SLN_DIR="C:\svn\"
SET SLN_NAME=test.sln

SET WEB_DIR="C:\inetpub\wwwroot\svn\"

SET YYYYMMDD=%DATE:/=%

REM これが空でないとMSBuildでエラーになる
SET PLATFORM=


REM 最新ソース取得
%SVN_EXE% update %SLN_DIR%

REM コード分析実行
CD %SLN_DIR%
DEL analyze.txt
ECHO 実行日時：%DATE% %TIME% > analyze.txt
%BUILD_EXE% %SLN_NAME% /p:RunCodeAnalysis=true /t:Rebuild /fl /flp:logfile=analyze.txt;verbosity=m;Append

REM 結果コピー
COPY /Y analyze.txt analyze_%YYYYMMDD%.txt
COPY /Y analyze.txt %WEB_DIR%analyze.txt
