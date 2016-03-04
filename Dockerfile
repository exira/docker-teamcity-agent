FROM java:8-jre
MAINTAINER Alexander Gorokhov <sashgorokhov@gmail.com>

RUN apt-get install -y unzip

ENV SERVER_URL="" \
    AGENT_N="1" \
    AGENT_DIR="/opt/teamcity_agent" \
    AGENT_OWN_ADDRESS="" \
    AGENT_OWN_PORT="9090"

ENV AGENT_NAME="Dockerized Agent #"$AGENT_N \
    AGENT_WORKDIR=$AGENT_DIR"/work_dir" \
    AGENT_TEMPDIR=$AGENT_DIR"/temp_dir"

WORKDIR $AGENT_DIR
EXPOSE $AGENT_OWN_PORT
VOLUME $AGENT_WORKDIR $AGENT_TEMPDIR

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /usr/bin/
RUN chmod +x /usr/bin/docker

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
