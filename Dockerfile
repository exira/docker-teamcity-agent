FROM java:8-jre
MAINTAINER Alexander Gorokhov <sashgorokhov@gmail.com>

RUN apt-get update && apt-get install -y unzip git

ENV SERVER_URL="" \
    AGENT_OWN_ADDRESS="" \
    AGENT_OWN_PORT="9090" \
    AGENT_NAME="" \
    AGENT_DIR="/opt/teamcity_agent"

ENV AGENT_WORKDIR=$AGENT_DIR"/work_dir" \
    AGENT_TEMPDIR=$AGENT_DIR"/temp_dir"

EXPOSE $AGENT_OWN_PORT
VOLUME $AGENT_WORKDIR $AGENT_TEMPDIR
WORKDIR $AGENT_DIR

COPY setup_agent.sh /

RUN \
    # Install docker
    wget -P /tmp https://get.docker.com/builds/Linux/x86_64/docker-1.11.2.tgz && \
    tar -xzf /tmp/docker-1.11.2.tgz -C / && rm /tmp/docker-1.11.2.tgz && \
    ln -s /docker/docker /usr/local/bin/docker && \

    # Install Mono
    apt-get update && apt-get install -y mono-complete && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt-get update && apt-get install -y mono-devel mono-complete ca-certificates-mono mono-4.0-service libmono-cil-dev && \

    # Install Node, NPM and Octopus Helpers
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    npm install bower octopus-deploy -g

CMD /setup_agent.sh && $AGENT_DIR/bin/agent.sh run
