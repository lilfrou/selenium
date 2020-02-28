                  ####################################################################################################
                  #                                        Tecmint_monitor.sh                                        #
                  # Written for Tecmint.com for the post www.tecmint.com/linux-server-health-monitoring-script/      #
                  # If any bug, report us in the link below                                                          #
                  # Free to use/edit/distribute the code below by                                                    #
                  # giving proper credit to Tecmint.com and Author                                                   #
                  #                                                                                                  #
                  ####################################################################################################
#! /bin/bash
# unset any variable which system may be using

# clear the screen


unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

while getopts iv name
do
        case $name in
          i)iopt=1;;
          v)vopt=1;;
          *)echo "Invalid arg";;
        esac
done

if [[ ! -z $iopt ]]
then
{
wd=$(pwd)
basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
scriptname=$(echo -e -n $wd/ 2> /dev/null && cat /tmp/scriptname) 2> /dev/null
su -c "cp $scriptname /usr/bin/monitor" root && echo "Congratulations! Script Installed, now run monitor Command" || echo "Installation failed"
}
fi

if [[ ! -z $vopt ]]
then
{
echo -e "tecmint_monitor version 0.1\nDesigned by Tecmint.com\nReleased Under Apache 2.0 License"
}
fi

if [[ $# -eq 0 ]]
then
{


# Define Variable tecreset
tecreset='&nbsp;'

echo -e  '<!DOCTYPE HTML>
<html>
<head>
<title>Report</title>
</head><body>'
# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e "<span style='color:#008000'>Internet:</span> $tecreset Connected" '<br><br>' || echo -e "<span style='color:#008000'>Internet:</span> $tecreset Disconnected" '<br><br>'

# Check OS Type
os=$(uname -o)
echo -e "<span style='color:#008000'>Operating System Type :</span>" $tecreset $os '<br><br>'

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e "<span style='color:#008000'>OS Name :</span>" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -e  '<br><br>'
echo -n -e "<span style='color:#008000'>OS Version :</span>" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"
echo -e  '<br><br>'
# Check Architecture
architecture=$(uname -m)
echo -e "<span style='color:#008000'>Architecture :</span>" $tecreset $architecture '<br><br>'

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e "<span style='color:#008000'>Kernel Release :</span>" $tecreset $kernelrelease '<br><br>'

# Check hostname
echo -e "<span style='color:#008000'>Hostname :</span>" $tecreset $HOSTNAME '<br><br>'

# Check Internal IP
internalip=$(hostname -I)
echo -e "<span style='color:#008000'>Internal IP :</span>" $tecreset $internalip '<br><br>'

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e "<span style='color:#008000'>External IP :</span> $tecreset "$externalip '<br><br>'

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e "<span style='color:#008000'>Name Servers :</span>" $tecreset $nameservers  '<br><br>'

# Check Logged In Users
who>/tmp/who
echo -e "<span style='color:#008000'>Logged In users :</span>" $tecreset && cat /tmp/who
echo -e  '<br><br>'
# Check RAM and SWAP Usages
free -h | column -t | sed 's:$:<br/>:;s:  *:</td><td>:;s:.*:<tr><td>&</td></tr>:'| grep -v + > /tmp/ramcache
echo -e "<span style='color:#008000'>Ram Usages :</span>" $tecreset '<br><br>''<table  border="1" >'
cat /tmp/ramcache | grep -v "Swap"
echo -e '</table>'
echo -e  '<br>'
echo -e "<span style='color:#008000'>Swap Usages :</span>" $tecreset '<br><br>''<table  border="1" >'
cat /tmp/ramcache | grep -v "Mem"
echo -e '</table>'
echo -e  '<br>'

# Check Disk Usages
df -h | column -t | sed 's:$:<br/>:;s:  *:</td><td>:;s:.*:<tr><td>&</td></tr>:'| grep 'Filesystem\|/dev/*' > /tmp/diskusage
echo -e "<span style='color:#008000'>Disk Usages :</span>" $tecreset  '<br><br>' '<table  border="1" >'
cat /tmp/diskusage 
echo -e '</table>'
echo -e  '<br>'
# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e "<span style='color:#008000'>Load Average :</span>" $tecreset $loadaverage '<br><br>'

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "<span style='color:#008000'>System Uptime Days/(HH:MM) :</span>" $tecreset $tecuptime '<br><br>'

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage
}
fi
shift $(($OPTIND -1))
echo -e  '</body></html>'
