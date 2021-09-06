@ECHO off

REM 環境設定
SET LANG=ja_JP.SJIS

SET HOME=C:\tools\namazu\
SET ITAIJIDICTPATH=%HOME%kakasi\share\kakasi\itaijidict
SET KANWADICTPATH=%HOME%kakasi\share\kakasi\kanwadict
SET MKNMZRC=%HOME%namazu\etc\namazu\mknmzrc
SET NAMAZULOCALEDIR=%HOME%namazu\share\locale\
SET NAMAZURC=%HOME%namazu\etc\namazu\namazurc

SET pkgdatadir=%HOME%namazu\share\namazu\
SET NAMAZU_EXE=%HOME%namazu\bin\mknmz.exe

SET IDX_DIR="C:\svn\index\
SET SLN_DIR="C:\svn\"
SET SLN_NAME=test.sln

SET YYYYMMDD=%DATE:/=%


REM 最新ソース取得
%SVN_EXE% update %SLN_DIR%

REM インデックスの構築
%NAMAZU_EXE% -U -O %IDX_DIR% %SLN_DIR%
