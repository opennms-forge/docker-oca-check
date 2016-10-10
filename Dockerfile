FROM jetty:9.2.19
MAINTAINER Ronny Trommer <ronny@opennms.org>

ENV OCA_CHECK_VERSION 1.1
ENV OCA_CHECK_WAR_URL https://github.com/opennms-forge/opennms-oca-github-plugin/releases/download/v${OCA_CHECK_VERSION}/oca-github-plugin-${OCA_CHECK_VERSION}.war
ENV OCA_CHECK_DEPLOY_DIR /var/lib/jetty/webapps
ENV OCA_PLUGIN_CONFIG_DIR /etc/oca-github-plugin
ENV OCA_PLUGIN_CONFIG /etc/oca-github-plugin/oca-github-plugin.properties
ENV OCA_PLUGIN_MAPPING /etc/oca-github-plugin/oca-mapping.properties
ENV GITHUB_API_TOKEN myToken
ENV GITHUB_USER myUser
ENV GITHUB_REPOSITORY myRepo
ENV GITHUB_WEBHOOK_SECRET myWebhookSecret
ENV OCA_REGEXP_REDO myRegexpRedo
ENV MAPPING_FILE_LOCATION myMappingFileLocation

RUN curl -L ${OCA_CHECK_WAR_URL} -o ${OCA_CHECK_DEPLOY_DIR}/oca-check.war && \
    mkdir /etc/oca-plugin

COPY assets/* /etc/oca-plugin/

## Volumes for storing data outside of the container
VOLUME [ "/etc/oca-github-plugin.properties" ]

EXPOSE 8080
