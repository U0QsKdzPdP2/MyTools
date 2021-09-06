@ECHO off
@SETLOCAL enabledelayedexpansion

SET SRV=(local)
SET DB=temp

SET AUTH=-T
REM SET AUTH=-U UserName -P ********

SET TimeTmp=%time: =0%
SET NOW=%date:/=%-%TimeTmp:~0,2%%TimeTmp:~3,2%%TimeTmp:~6,2%
SET LOG=%NOW%.log


FOR /f %%V IN (..\..\..\src\Temp\Temp.Biz\Settings\TempTables.txt) DO (

    ECHO %%V
    ECHO %%V >> !LOG!

    IF EXIST .\csv\%%V.csv (

        bcp %%V in .\csv\%%V.csv -f .\format\%%V.xml -t , -S !SRV! !AUTH! -d !DB! -o .\log\%%V_!LOG! -e .\log\Error_%%V_!LOG!

    ) ELSE (

        ECHO SKIP
    )
)

PAUSE
