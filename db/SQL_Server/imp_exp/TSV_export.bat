chcp 932

set SRV=(local)
set DB=Temp
set DATA=tsv
set AUTH=-T


bcp Temp1 out .\%DATA%\Temp1.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% %AUTH%
bcp Temp2 out .\%DATA%\Temp2.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% %AUTH%
bcp Temp3 out .\%DATA%\Temp3.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% %AUTH%

PAUSE
