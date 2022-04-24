#!/bin/bash
echo "1, To add a new server to an existing client "
echo -ne "2, To add a new server under a new client \n"
while true; do
read -p "Please enter the number [1-2] :" numb
case $numb in
       		[1] )  break;;
       		[2] ) break;;
	 esac
done
ExtClient()
{
        read -p "Specify the Client Name: " extclient
        read -p "Enter the Server Name (hostname) : " host1
        read -p "Enter the user through which you want to SSH : " user1
        read -p "Enter the IP or Hostname : " hname_ip
        read -p "Enter the port Number (default : 22) :" port1
        port1="${port1:=22}"
        echo -e "ssh ${user1}@${hname_ip} -p ${port1}" > /home/cbn/psh_extcli/${extclient}/${host1}
        ssh-copy-id ${user1}@${hname_ip} -p ${port1}
}

NewClient()
{
        read -p "enter the client name :" client
        mkdir -p /home/cbn/psh_extcli/${client}
        groupadd ${client}
        chmod g+s /home/cbn/psh_extcli/${client}
        setfacl -m g:${client}:rx /home/cbn/psh_extcli/${client}
        setfacl -d -m g:${client}:rx /home/cbn/psh_extcli/${client}
        chgrp -R testgrp /home/cbn/psh_extcli/${client}
}

if [ ${numb} == 1 ]
then
	ExtClient
else
	NewClient
	ExtClient
fi
