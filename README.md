# TeamCity Agent

![teamcity-agent v4](https://img.shields.io/badge/teamcity--agent-v4-brightgreen.svg?style=flat-square) [![](https://images.microbadger.com/badges/image/exira/teamcity-agent.svg)](https://microbadger.com/#/images/exira/teamcity-agent)

TeamCity is a Java-based build management and continuous integration server from JetBrains.

> [https://en.wikipedia.org/wiki/TeamCity](https://en.wikipedia.org/wiki/TeamCity)

# How to use this image

```console
$ docker run --name teamcity-agent -p 9090:9090 -e SERVER_URL=http://example.com -d exira/teamcity-agent:4
```

This will start a Teamcity agent listening on the default port of 9090.
`SERVER_URL` environment variable is <b>required</b>. Otherwize container will exit with exit code 1.
If agent wont be able to connect to teamcity server at `SERVER_URL` within 180 seconds, it will exit with exit code 2.

# Environment Variables

Required:
- `SERVER_URL`

Optional environment variables:
- `AGENT_OWN_ADDRESS`
- `AGENT_OWN_PORT` (if you set this variable, you must rebuild image with this environment variable set)
- `AGENT_NAME`
- `AGENT_DIR` - directory where agent sources live. Default: `/opt/teamcity_agent`
- `AGENT_WORKDIR` Default: `$AGENT_DIR"/work_dir"`
- `AGENT_TEMPDIR` Default: `$AGENT_DIR"/temp_dir"`

Documentation about agent parameters: [official teamcity docs](https://confluence.jetbrains.com/display/TCD9/Build+Agent+Configuration)

# How to extend this image

By default, when running this image, you will get a basic container with only running agent in it and pre-installed git.
If you would like to do additional initialization in container, add one or more *.sh scripts under `/agent-init.d/`. After agent installs, script will source any *.sh scripts found in that directory to do further initialization before starting the service.

For example, you can mount such scripts as `-v /path/script.sh:/agent-init.d/script.sh`.

# Using host's docker engine within agent container

If you want to be able to build, run, compose docker in builds running by agent container, there are good news for you:
this image has a pre-installed docker client.

All you must to do is to mount your host's docker socket via `-v /var/run/docker.sock:/var/run/docker.sock`. And you will be able to use your hosts docker engine!

Using host's docker-compose: `-v /usr/local/bin/docker-compose:/bin/docker-compose`

Using host's docker-machine: `-v /usr/local/bin/docker-machine:/bin/docker-machine`
