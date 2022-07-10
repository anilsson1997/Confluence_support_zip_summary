#!/bin/bash

############### global vars ###############

# Unzipping the argument given file 
SUPPORTZIPFILEPATHFULL=$1
SUMMARYFILEPATH="/tmp/confluenceSummary.txt"
WORKDIR="/tmp"


#Helper Vars
color='\e[1;34m'
NC='\e[0m'
SUPPORTZIPFILEPATH=$(echo "$SUPPORTZIPFILEPATHFULL" | cut -f 1 -d '.')
TODAY=$(date '+%d_%m_%Y')

################ functions ################

function seperator() {
    echo "================================================================================"
    echo "$1"
    echo "================================================================================"
}

################## main ###################

if [[ -z "${SUPPORTZIPFILEPATH}" ]]; then
    echo "Support.Zip Filepath not set. Please start script again! supportZipSummary.sh <FilePath>"
    exit 1
fi

echo -e "${color} hello, $USER. This is the tets script to automate a summary for confluence support zip ${NC}"
echo -e "${color} It starts with unzipping the support zip file passed as an argument ${NC}"

unzip $SUPPORTZIPFILEPATH -d $WORKDIR/confluence-support-$TODAY

sleep 10

# Starting to GREP the info
seperator "The last Start of Confluence" >$SUMMARYFILEPATH
grep -R -A 23 "Starting Confluence" $WORKDIR/confluence-support-$TODAY/application-logs | tail -24 >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "Build Info" $WORKDIR/confluence-support-$TODAY >>$SUMMARYFILEPATH
grep -R "baseUrl =" $WORKDIR/confluence-support-$TODAY --exclude=*.sh | tail -1 | cut -d':' -f1- | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "home =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "upTime =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "devMode =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "server.id =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "supportEntitlementNumber =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "installationDate =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "version =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "XML Value Tags: " >>$SUMMARYFILEPATH
grep -R "clustered" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "confluence.cluster.peers" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "Server Info" >>$SUMMARYFILEPATH
grep -R "Application Server:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Servlet Version:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "Database Info" >>$SUMMARYFILEPATH
grep -R "Database Dialect:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Database URL:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Database Driver Name:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Database Driver Version:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Database Version:" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "Database Latency (ms):" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "Usage Info" >>$SUMMARYFILEPATH
echo -e "XML Value Tags: " >>$SUMMARYFILEPATH
grep -R "total.spaces" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "<groups>" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "<users>" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "active-users" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "licensed-users" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "license-type" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "license-period" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "global.spaces" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "allContent" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "indexSize" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "personal.spaces" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "content.current" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "System Info & JVM Stats" >>$SUMMARYFILEPATH
grep -R "javaRuntime =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "operatingSystem =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "jvmVersion =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "fileSystemEncoding =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "javaVendor =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "jvmImplementationVersion =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "systemTimezone =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "appServer =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "favouriteCharacter =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "tempDirectory =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "jvmInputArguments =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "jvmVendor =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "userName =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "javaVersion =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "operatingSystemArchitecture =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "systemLanguage =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
grep -R "workingDirectory =" $WORKDIR/confluence-support-$TODAY | tail -1 | cut -d':' -f2- >>$SUMMARYFILEPATH
echo -e "">>$SUMMARYFILEPATH

seperator "System Health Check" >>$SUMMARYFILEPATH
cat $WORKDIR/confluence-support-$TODAY/healthchecks/healthcheckResults.txt >>$SUMMARYFILEPATH

rm -rf $WORKDIR/confluence-support-$TODAY
echo -e "\n"
echo -e " Summary created successfully at $SUMMARYFILEPATH"

read -p "Do you want to open the file (Y/N)?" CHOICE
if [ "$CHOICE" != "${CHOICE#[yY]}" ]; then

    echo -e "${color}"
    cat $SUMMARYFILEPATH

else

    echo -e "Please open file manually"

fi
