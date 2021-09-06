@ECHO off
@SETLOCAL enabledelayedexpansion

SET SRV=(local)
SET DB=temp

SET AUTH1=-E
SET AUTH2=-T
REM SET AUTH1=-U UserName -P ********
REM SET AUTH2=%AUTH1%

SET TimeTmp=%time: =0%
SET NOW=%date:/=%-%TimeTmp:~0,2%%TimeTmp:~3,2%%TimeTmp:~6,2%
SET LOG=.\import_%NOW%.log


IF NOT EXIST .\log\ ( MKDIR .\log\ )


FOR /f %%V IN (..\..\..\src\Temp\Temp.Biz\Settings\TempTables.txt) DO (

    ECHO %%V

    REM 文字の置換（[＿]-> [_]）
    SET TMP=%%V
    SET TBL=!TMP:＿=_!

    IF EXIST .\csv\!TBL!.csv (

        sqlcmd -S !SRV! !AUTH1! -d !DB! -E -Q "TRUNCATE TABLE %%V" >> !LOG!

        bcp %%V in .\csv\%%V.csv -f .\format\%%V.xml -t , -F 2 -S !SRV! !AUTH2! -d !DB! -o .\log\%%V.log -e .\log\%%V_Error.log

    ) ELSE (

        ECHO SKIP %%V >> !LOG!
    )
)

REM ゼロバイトのエラーログの削除
FOR %%V IN (.\log\*._Error.log) DO ( IF %%~zI==0 DEL %%I )
FOR %%V IN (*.log) DO ( IF %%~zI==0 DEL %%I )

PAUSE
