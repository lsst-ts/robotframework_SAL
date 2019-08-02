#!/bin/bash

# These variables hold a path to the location of base repositories. The scripts
# within this repo will use these environment variables to create other paths 
# that are needed to function. 

export ROBOTFRAMEWORK_SAL_DIR=/home/aheyer/tsrepos/robotframework_SAL
export TS_XML_REPO_DIR=/home/aheyer/tsrepos/ts_xml

# There is python library called xmlstarlet using in this repo. wether you call
# 'xml' or 'xmlstarlet' is platform specific. For portability we alias here
# both ways of calling the library.

alias xml='xmlstarlet'
