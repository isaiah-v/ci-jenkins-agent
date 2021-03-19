# ci-jenkins-agent

A jenkins agent setup to connect directly to our Jenkins instance. This setup is based on the documentation specifying how to [connect directly to TCP port](https://github.com/jenkinsci/remoting/blob/master/docs/inbound-agent.md#connect-directly-to-tcp-port).

## Environmental Variables
`DIRECT` - You need to specify the host and port, in a typical `HOST:PORT` fashion. The HOST can be whatever name or address resolves to the server. The PORT value can be determined by examining the JNLP file or looking at the Agents section of the server Configure Global Security page.

`INSTANCE_IDENTITY` - Each Jenkins instance has its own [Instance Identity](https://wiki.jenkins.io/display/JENKINS/Instance+Identity). The agent needs this key to complete the connection. You can obtain this value via the script console or the Instance Identity page.
 
 `SECRET` - Your secret key defined in your agent status.
 
 `AGENT` - You must provide the agent name. This is easily obtained from the agent status page or other places.
 
 ## Build
 ```
 git clone https://github.com/isaiah-v/ci-jenkins-agent.git
 cd ci-jenkins-agent
 sudo docker build --tag ci-jenkins-agent:latest .
 ```
 
 ## Run
 
 Without Docker:
 ```
 sudo docker run -d --restart=always --name ci-jenkins-agent --env-file env-file ci-jenkins-agent:latest
```

With Docker:
```
sudo docker run -d --restart=always --name ci-jenkins-agent --env-file env-file -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) ci-jenkins-agent:latest
```
