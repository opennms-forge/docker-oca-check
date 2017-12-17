[![](https://images.microbadger.com/badges/image/opennms/oca-check.svg)](https://microbadger.com/images/opennms/oca-check "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/opennms/oca-check.svg)](https://microbadger.com/images/opennms/oca-check "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/opennms/oca-check.svg)](https://microbadger.com/images/opennms/oca-check "Get your own version badge on microbadger.com")

## Supported tags

* `latest`, latest develop release

### latest

* Jetty 9.4.6
* OCA GitHub Plugin 1.1

## OCA check service for GitHub

This service checks contributors in GitHub pull requests if they have signed the OpenNMS Contribution Agreement (OCA).
The mail address of the pull request contributor is verified against the list in the link:https://wiki.opennms.org/wiki/Executed_contributor_agreements[OpenNMS Wiki].

## Requirements

Running the service requires:

* Access to administrative settings in GitHub project
* Service must be available on the Internet with public IP address or DNS name and requires a Webhook entry in the GitHub project
* Docker Engine 1.12+
* optional Docker Compose 1.8+

## Configuration

The service can be configured with environment variables.
Following variables are available:

| Variable                | Description                                                                                                                        | Default                       |
|:------------------------|:-----------------------------------------------------------------------------------------------------------------------------------|:------------------------------|
| `OCA_PLUGIN_CONFIG_DIR` | Location for properties config file                                                                                                | `/etc/oca-github-plugin`      |
| `OCA_PLUGIN_CONFIG`     | OCA global configuration file in config directory                                                                                  | `oca-github-plugin.properties`|
| `OCA_PLUGIN_MAPPING`    | Allow mapping of multiple mail addresses to a GitHub user in config directory                                                      | `oca-mapping.properties`      |
| `GITHUB_API_TOKEN`      | GitHub API Token                                                                                                                   | myToken                       |
| `GITHUB_USER`           | GitHub user with permissions to the repository                                                                                     | myUser                        |
| `GITHUB_REPOSITORY`     | GitHub repository for Pull Requests to check                                                                                       | myRepo                        |
| `GITHUB_WEBHOOK_SECRET` | GitHub webhook secret                                                                                                              | myWebhookSecret               |
| `OCA_REGEXP_REDO`       | Commands which allow triggering the OCA check manually through Pull Request comment, e.g. <code>.*(a7lfred&#124;ulf).*oca.*</code> | myRegexpRedo                  |
| `MAPPING_FILE_LOCATION` | Location of the mapping file for multiple mailaddresses to a single GitHub user                                                    | myMappingFileLocation         |

## Usage

Create a `.oca_check.env` file with your settings as shown in the example.

Global configuration for `oca-github-plugin.properties`

```
GITHUB_API_TOKEN=myGitHubApiToken
GITHUB_USER=myGitHubUser
GITHUB_REPOSITORY=myGitHubRepository
GITHUB_WEBHOOK_SECRET=myGitHubWebhookSecret
OCA_REGEXP_REDO=myOcaRegexpForRecheck
MAPPING_FILE_LOCATION=/path/to/mappingfile.properties
```

Run the containerized service using `docker-compose`

```
docker-compose up -d
```

Service can be tested with the _health_ ReST endpoint:

```
curl -I http://localhost:8080/oca-check/rest/health
HTTP/1.1 200 OK
```
