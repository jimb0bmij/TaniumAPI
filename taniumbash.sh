#!/bin/bash

TSESSIONV=$(curl -k -s -X POST --data-binary @session.json https://example.com/api/v2/session/validate )

if echo $TSESSIONV |grep -Ei 'invalid|forbidden'; then

TSESSION=$(curl -k -s -X POST --data-binary @login.json https://example.com/api/v2/session/login )
echo $TSESSION > session1.json
jq '.data' session1.json > session.json
TSESSIONS=$(jq -r '.data.session' session1.json)

else

TSESSIONS=$(jq -r '.data.session' session1.json)
echo "vaild $TSESSIONV"


cat session.json
cat session1.json

echo "tsession $TSESSION"
echo "tsessions $TSESSIONS"

curl -k -s -X GET -H "session:$TSESSIONS"  https://example.com/api/v2/api_tokens

#curl -k -s -X POST -H "session:$TSESSIONS" --data "{ }"  https://example.com/api/v2/api_tokens
fi
