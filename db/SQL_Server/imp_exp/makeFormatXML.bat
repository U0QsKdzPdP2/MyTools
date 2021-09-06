chcp 932

SET SRV=(local)
SET DB=Temp
SET DATA=tsv
SET USER=user1
SET PASS=********


bcp Temp1 format nul -c -t \t -x -f .\format\Temp1.Xml -T -d %DB%
bcp Temp2 format nul -c -t \t -x -f .\format\Temp2.Xml -T -d %DB%
bcp Temp3 format nul -c -t \t -x -f .\format\Temp3.Xml -T -d %DB%

PAUSE
