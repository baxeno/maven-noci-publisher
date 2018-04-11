# maven-noci-publisher

This tool make it possible to publish Maven artifacts into [Artifactory](https://jfrog.com/artifactory/) using [Gradle](https://gradle.org/) without a [Jenkins](https://jenkins.io/) CI pipeline.

## Requirements

**Shell:**

Use one of the following shells to execute the `publish.sh` script:

_Linux:_ Bash

_Windows:_ GitBash

> Note: Other shells might also work but has not been tested.

**Artifactory permissions:**

The user running this tool must have `Deploy/Cache` permissions to Maven repositories.

**Gradle (Artifactory) configuration:**

Setup Artifactory credentials for use in Gradle.

_Linux:_ `~/.gradle/init.d/artifactory.gradle`

_Windows:_ `C:\Users\xxx\.gradle\init.d\artifactory.gradle`

> Note: Create parent directories in case they don't exist, ex. `mkdir -p ~/.gradle/init.d`.

Template for`artifactory.gradle` can be seen below:

```
allprojects {
  ext {
    artifactory_contextUrl = "https://artifactory.company.com/artifactory"
    artifactory_user = "xxx"
    artifactory_password = "123456789abcdef01234567890"
  }
}
```

> Note: Use API key from Artifactory as `artifactory_password`.
> 1) Avoid leaving your password in a plain text file.
> 2) No need to change it in case of Active Directory integration with password expiration.

## Usage

0) Read requirements above ;)

1) Copy artifacts to the directory where this git repository is cloned.

2) Modify `publish.sh` with your new Maven artifacts using one or more calls to the functions below.

```
publish_internal_artifact <artifactGroup> <artifactId> <artifactVersion> <artifact1> [<artifact2>]

publish_3rdparty_artifact <artifactId> <artifactVersion> <artifact1> [<artifact2>]
```

3) Run script: `./publish.sh`.

### Configuration

Default tool configuration uses the following Maven repository names:

**Internal company components:**

Components in this repository should all use [semantic versioning](https://semver.org/) so your pipelines can take advantage of dynamic dependency management in a continues delivery flow.

Maven repository: `maven-release-local`


**3rd party components:**

Components in this repository will have many different version formats and therefore you cannot use dynamic dependency management.

Maven repository: `maven-3rdparty-local`
