#!/bin/bash

LISTEN=$1

export SCRIPT_NAME=/fpm_status
export SCRIPT_FILENAME=/fpm_status

if [[ $2 == "full" || $3 == "full" ]]
then
        export QUERY_STRING+="full&"
fi
if [[ $2 == "json" || $3 == "json" ]]
then
        export QUERY_STRING+="json&"
fi

export REQUEST_METHOD=GET

CGI2FCGI=/usr/bin/cgi-fcgi

if [ ! -x ${CGI2FCGI} ]
then
        echo "cgi-fcgi does not appear to be installed:"
        echo -e "\t* On debian this can be installed with: $ sudo apt-get install libfcgi0ldbl\n"
        exit 1
fi

#if [ ! -S ${LISTEN} ]
#then
#        echo "${LISTEN} does not appear to be a socket"
#        exit 1
#fi

${CGI2FCGI} -bind -connect ${LISTEN}
