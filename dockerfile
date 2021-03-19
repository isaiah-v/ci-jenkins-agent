FROM adoptopenjdk:11-jdk-hotspot

ENV WORK_DIR /var/jenkins_agent/
ENV PROTOCOLS JNLP4-connect
ENV DIRECT=
ENV INSTANCE_IDENTITY=
ENV SECRET=
ENV AGENT=

RUN apt-get update
RUN apt-get -y install git

RUN mkdir -p /var/jenkins_agent/workspace
COPY ./agent.jar /var/jenkins_agent/agent.jar

WORKDIR /var/jenkins_agent/

CMD java -cp agent.jar hudson.remoting.jnlp.Main -headless -workDir $WORK_DIR -direct $DIRECT -protocols $PROTOCOLS -instanceIdentity $INSTANCE_IDENTITY $SECRET $AGENT;
