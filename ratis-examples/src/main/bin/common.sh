#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

echo "SCRIPT_DIR inside common.sh"  $SCRIPT_DIR

LIB_DIR=${SCRIPT_DIR}/../lib

echo "LIB_DIR inside common.sh"  $LIB_DIR
echo ""

if [[ -d "$LIB_DIR" ]]; then
   #release directory layout
   LIB_DIR=`cd ${LIB_DIR} > /dev/null; pwd`
   ARTIFACT=`ls -1 ${LIB_DIR}/*.jar`
   echo "Printing ARTIFACT inside common.sh"   $ARTIFACT
else
   #development directory layout
   EXAMPLES_DIR=${SCRIPT_DIR}/../../../
   echo "Printing examples Dir inside common.sh"  $EXAMPLES_DIR
   if [[ -d "$EXAMPLES_DIR" ]]; then
      EXAMPLES_DIR=`cd ${EXAMPLES_DIR} > /dev/null; pwd`
   fi
   JAR_PREFIX=`basename ${EXAMPLES_DIR}`
   echo "JAR_PREFIX inside common.sh"  $JAR_PREFIX
   echo "list target folder in examples dir" ls -1 ${EXAMPLES_DIR}/target/
   ARTIFACT=`ls -1 ${EXAMPLES_DIR}/target/${JAR_PREFIX}-*.jar | grep -v test | grep -v javadoc | grep -v sources | grep -v shaded`
   echo "Printing Artifacts inside common.sh"  $ARTIFACT
   if [[ ! -f "$ARTIFACT" ]]; then
      echo "Jar file is missing. Please do a full build (mvn clean package -DskipTests) first."
      exit -1
   fi
fi

echo "Found ${ARTIFACT}"

QUORUM_OPTS="--peers n0:localhost:6000,n1:localhost:6001,n2:localhost:6002"

CONF_DIR="$DIR/../conf"
echo "CONF_DIR" $CONF_DIR
if [[ -d "${CONF_DIR}" ]]; then
  LOGGER_OPTS="-Dlog4j.configuration=file:${CONF_DIR}/log4j.properties"
else
  LOGGER_OPTS="-Dlog4j.configuration=file:${DIR}/../resources/log4j.properties"
fi
