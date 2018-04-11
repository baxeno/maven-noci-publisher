#!/bin/bash

# Detect who is running this publish.
USER_NAME="UNKNOWN"
if [ -n "${USER}" ]; then
  USER_NAME="${USER}"
fi
if [ -n "${USERNAME}" ]; then
  USER_NAME="${USERNAME}"
fi

DRY_RUN=0
INTERNAL_REPO="maven-release-local"
THIRDPARTY_REPO="maven-3rdparty-local"

set -e # Exit script when a statement returns a non-true value
set -u # Exit script when using an uninitialised variable

_publish_artifact()
{
  {
    echo "org.gradle.daemon=false"
    echo "repoName=${1}"
    echo "version=${2}"
    echo "publishRepo=${3}"
    echo "group=${4}"
    echo "userPublisher=${USER_NAME}"
    echo "publicationType=${5}"
    echo "existingArtifactOne=${6}"
    echo "existingArtifactTwo=${7}"
  } > "gradle.properties"
  if [ "${DRY_RUN}" -eq 0 ]; then
    ./gradlew artifactoryPublish
    sleep 1
    rm -rf "gradle.properties"
  fi
}

publish_3rdparty_artifact()
{
  if [ $# -lt 3 ] || [ $# -gt 4 ]; then
    echo "Error! Wrong amount of arguments!"
    echo; echo "Usage: publish_3rdparty_artifact <artifactId> <artifactVersion> <artifact1> [<artifact2>]"
    echo; echo "This function can publish one or two files/directories into ${THIRDPARTY_REPO} repository."
    echo; echo "Ex."
    echo "  publish_3rdparty_artifact \"ptxdist\" \"2016.06.1\" \"ptxdist-2016.06.1.tar.bz2\""
    echo "  publish_3rdparty_artifact \"linux\" \"4.7.10\" \"linux-4.7.tar.xz\" \"patch-4.7.10.xz\""
    return 1
  fi
  if [ $# -eq 3 ]; then
    _publish_artifact "${1}" "${2}" "${THIRDPARTY_REPO}" "3rdparty" "nociPublication" "${3}" ""
  else
    _publish_artifact "${1}" "${2}" "${THIRDPARTY_REPO}" "3rdparty" "nociPublication" "${3}" "${4}"
  fi
}

publish_internal_artifact()
{
  if [ $# -lt 4 ] || [ $# -gt 5 ]; then
    echo "Error! Wrong amount of arguments!"
    echo; echo "Usage: publish_internal_artifact <artifactGroup> <artifactId> <artifactVersion> <artifact1> [<artifact2>]"
    echo; echo "This function can publish one or two files/directories into ${INTERNAL_REPO} repository."
    echo; echo "Ex."
    echo "  publish_internal_artifact \"com.company.department.project\" \"component\" \"0.3.2\" \"smart-stuff-v3-new-new.hex\""
    return 1
  fi
  if [ $# -eq 4 ]; then
    _publish_artifact "${2}" "${3}" "${INTERNAL_REPO}" "${1}" "nociPublication" "${4}" ""
  else
    _publish_artifact "${2}" "${3}" "${INTERNAL_REPO}" "${1}" "nociPublication" "${4}" "${5}"
  fi
}
