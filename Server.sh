ubuntu@ip-172-31-4-151:~$ cat Server.sh 
#!/bin/bash

SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
SERVER="3.139.172.209"
LOG_FILE="/tmp/server_uptime_monitor.log"

ping -c 2 $SERVER &> /dev/null

if [ $? -ne 0 ]; then

         MESSAGE=":warning: *ALERT*: Server *$SERVER* is *DOWN* at $(date)"
       
    curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" \
    "$SLACK_WEBHOOK_URL"

  echo "$(date) : Server $SERVER is Down " >> $LOG_FILE

else
        MESSAGE=":white_check_mark: Server *$SERVER* is *UP* at $(date)"

        curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$MESSAGE\"}" \
        "$SLACK_WEBHOOK_URL"
fi
