FROM sashgorokhov/teamcity-agent
MAINTAINER Alexander Gorokhov <sashgorokhov@gmail.com>

RUN apt-get update && \
    apt-get install -y python python-dev python-pip python3 python3-dev python3-pip git
RUN pip install virtualenv
