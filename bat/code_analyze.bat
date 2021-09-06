@ECHO off

REM ���ݒ�
SET SVN_EXE="C:\Program Files\TortoiseSVN\bin\svn.exe"
SET BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"

SET SLN_DIR="C:\svn\"
SET SLN_NAME=test.sln

SET WEB_DIR="C:\inetpub\wwwroot\svn\"

SET YYYYMMDD=%DATE:/=%

REM ���ꂪ��łȂ���MSBuild�ŃG���[�ɂȂ�
SET PLATFORM=


REM �ŐV�\�[�X�擾
%SVN_EXE% update %SLN_DIR%

REM �R�[�h���͎��s
CD %SLN_DIR%
DEL analyze.txt
ECHO ���s�����F%DATE% %TIME% > analyze.txt
%BUILD_EXE% %SLN_NAME% /p:RunCodeAnalysis=true /t:Rebuild /fl /flp:logfile=analyze.txt;verbosity=m;Append

REM ���ʃR�s�[
COPY /Y analyze.txt analyze_%YYYYMMDD%.txt
COPY /Y analyze.txt %WEB_DIR%analyze.txt
