@ECHO off
setlocal ENABLEDELAYEDEXPANSION

chcp 932

CLS

SET SRV=(local)
SET DB=temp

SET time2=%time: =0%
SET TODAY=%date:~-10,4%%date:~-5,2%%date:~2,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%
SET LOG_FILE=_%TODAY%.log

REM データ削除
FOR %%V IN (./tsv/*.tsv) DO (

  sqlcmd -S !SRV! -d !DB! -E -Q "DELETE FROM %%~nV" -o "log\del_%%~nV!LOG_FILE!"
  ECHO 削除実行 %%V
)
ECHO データ削除が完了しました。


REM データインポート
FOR %%V IN (./tsv/*.tsv) DO (

  sqlcmd -S !SRV! -d !DB! -E -v CUR_DIR="%~dp0" TABLE_NAME="%%~nV" EXTENSION=".tsv" FIELDTERMINATOR="\t" FORMAT="format\%%~nV.xml" -i .\bulk_insert.sql -o ".\log\imp_%%~nV!LOG_FILE!"
  ECHO データインポート実行 %%V
)
ECHO データインポートが完了しました。

PAUSE
