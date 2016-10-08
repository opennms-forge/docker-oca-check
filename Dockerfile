FROM jetty:9.2.19
MAINTAINER Ronny Trommer <ronny@opennms.org>

ENV OCA_CHECK_VERSION 1.1
ENV OCA_CHECK_WAR_URL https://github.com/opennms-forge/opennms-oca-github-plugin/releases/download/v${OCA_CHECK_VERSION}/oca-github-plugin-${OCA_CHECK_VERSION}.war
ENV OCA_CHECK_DEPLOY_DIR /var/lib/jetty/webapps

RUN curl -L ${OCA_CHECK_WAR_URL} -o ${OCA_CHECK_DEPLOY_DIR}/oca-check.war

## Volumes for storing data outside of the container
VOLUME [ "/etc/oca-github-plugin.properties" ]

EXPOSE 8080
