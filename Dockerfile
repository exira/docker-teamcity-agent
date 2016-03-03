FROM sashgorokhov/teamcity-agent
MAINTAINER Alexander Gorokhov <sashgorokhov@gmail.com>

RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip
RUN pip3 install virtualenv