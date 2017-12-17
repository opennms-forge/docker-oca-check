FROM jetty:9.4.6
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
    mkdir ${OCA_PLUGIN_CONFIG_DIR}

COPY assets/* ${OCA_PLUGIN_CONFIG_DIR}/
COPY ./docker-entrypoint.sh /

HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail -s -I curl -I http://localhost:8080/oca-check/rest/health | grep "HTTP/1.1 200 OK" || exit 1

LABEL license="GPLv3" \
      org.opennms.ocacheck.version="${OCA_CHECK_VERSION}" \
      vendor="OpenNMS Community" \
      name="OCA Check GitHub Plugin"

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "-h" ]

EXPOSE 8080
