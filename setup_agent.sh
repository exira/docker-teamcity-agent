#!/bin/bash
set -e

if [ -z "$SERVER_URL" ]; then
    echo SERVER_URL environment variable not set\; Exiting
    exit 1
fi

waiting=0
until curl -sfIX GET $SERVER_URL/update/buildAgent.zip; do
    let waiting+=3
    sleep 3
    if [ $waiting -eq 180 ]; then
        echo "Teamcity server did not respond within 180 seconds"
        exit 2
    fi
done

wget ${SERVER_URL}/update/buildAgent.zip && unzip -d ${AGENT_DIR} buildAgent.zip && rm buildAgent.zip

echo "serverUrl=${SERVER_URL}" > ${AGENT_DIR}/conf/buildAgent.properties
echo "workDir=${AGENT_WORKDIR}" >> ${AGENT_DIR}/conf/buildAgent.properties
echo "tempDir=${AGENT_TEMPDIR}" >> ${AGENT_DIR}/conf/buildAgent.properties
echo "ownPort=${AGENT_OWN_PORT}" >> ${AGENT_DIR}/conf/buildAgent.properties

if [ -n "$AGENT_NAME" ]; then
    echo "name=${AGENT_NAME}" >> ${AGENT_DIR}/conf/buildAgent.properties
fi
if [ -n "$AGENT_OWN_ADDRESS" ]; then
    echo "ownAddress=${AGENT_OWN_ADDRESS}" >> ${AGENT_DIR}/conf/buildAgent.properties
fi

chmod +x ${AGENT_DIR}/bin/agent.sh

echo Running init scripts...
for f in /agent-init.d/*; do
	case "$f" in
		*.sh)     echo "$0: running $f"; . "$f" ;;
		*)        echo "$0: ignoring $f" ;;
	esac
	echo
done