#!/bin/bash

source functions.sh

## This is examples of how to publish artifacts in a Maven repository on Artifactory.
## Add one line for each artifact.
##
## Note: Lines must be uncommented in order to execute when running: ./publish.sh

# publish_3rdparty_artifact "e2fsprogs" "1.44.1" "e2fsprogs-1.44.1.tar.gz"
# publish_3rdparty_artifact "iar_embedded_workbench_arm" "7.50.3" "iar_embedded_workbench_arm/**/*"
# publish_internal_artifact "com.company.department.project" "component" "0.3.2" "smart-stuff-v3-new-new.hex"
