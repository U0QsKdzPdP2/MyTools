@ECHO off
SETLOCAL enabledelayedexpansion

SET SRC_DIR=G:\backup\
SET DST_DIR=I:\backup\

SET TimeTmp=%time: =0%
SET NOW=%date:/=%-%TimeTmp:~0,2%%TimeTmp:~3,2%%TimeTmp:~6,2%
SET LOG_DIR=.\backup\xx_log\
SET LOG_RCP=%LOG_DIR%_%NOW%_robocopy.log
SET LOG_SRC=%LOG_DIR%_%NOW%_dir_src.log
SET LOG_DST=%LOG_DIR%_%NOW%_dir_dst.log


ECHO Do you want to run robocopy ? (Y/N)

SET /P P1=
IF NOT %P1%==Y  GOTO SKIP


REM robocopy.exe  %SRC_DIR%  %DST_DIR%  /E /NP /TEE /LOG:%LOG%
robocopy.exe  %SRC_DIR%  %DST_DIR%  /MIR /NP /TEE /LOG:%LOG_RCP%

dir /s /b /a-d %SRC_DIR% > temp_src.txt
dir /s /b /a-d %DST_DIR% > temp_dst.txt

powershell -File _file_replace.ps1 temp_src.txt %SRC_DIR% > %LOG_SRC%
powershell -File _file_replace.ps1 temp_dst.txt %DST_DIR% > %LOG_DST%

DEL /Q temp_src.txt
DEL /Q temp_dst.txt


:SKIP
PAUSE
