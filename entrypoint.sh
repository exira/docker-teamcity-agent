let waiting=0
until curl -s -f -I -X GET ${SERVER_URL}/update/buildAgent.zip; do
    let waiting+=3
    sleep 3
    if [ ${waiting} -eq 120 ]; then
        echo "Teamcity server did not respond within 120 seconds"
        exit 42
    fi
done

wget ${SERVER_URL}/update/buildAgent.zip && unzip -d ${AGENT_DIR} buildAgent.zip && rm buildAgent.zip

echo "serverUrl=${SERVER_URL}" > ${AGENT_DIR}/conf/buildAgent.properties
echo "name=${AGENT_NAME}" >> ${AGENT_DIR}/conf/buildAgent.properties
echo "workDir=${AGENT_WORKDIR}" >> ${AGENT_DIR}/conf/buildAgent.properties
echo "tempDir=${AGENT_TEMPDIR}" >> ${AGENT_DIR}/conf/buildAgent.properties
echo "ownPort=${AGENT_OWN_PORT}" >> ${AGENT_DIR}/conf/buildAgent.properties
# echo "ownAddress=${AGENT_OWN_ADDRESS}" >> ${AGENT_DIR}/conf/buildAgent.properties

chmod +x ${AGENT_DIR}/bin/agent.sh
bash ${AGENT_DIR}/bin/agent.sh run