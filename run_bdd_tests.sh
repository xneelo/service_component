#!/bin/bash

#This script must be run from the parent folder of the soar_sc, service_component repo folders
export BASE_DIR=$(pwd)

export SOAR_DIR=../soar_sc
export SERVICE_COMPONENT_DIR=$BASE_DIR

echo "Cleaning all repos involved in testing in preparation for jewel injection"
cd $SOAR_DIR && git checkout . && git clean -fdx
#cd $SERVICE_COMPONENT_DIR && git checkout . && git clean -fdx

echo "Import soar_audit_test_service to audit related testing"
cd $SERVICE_COMPONENT_DIR && ./import.sh service_component
cd $SERVICE_COMPONENT_DIR && ./import.sh policy_is_anyone

echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
git checkout config/config.yml
cp config/environment.yml.example config/environment.yml
export SOAR_TECH=rackup
export RACK_ENV=production
./soar_tech.sh
rvm use . && gem install bundler && bundle

./keep_running.sh > /dev/null 2>&1 &
export KEEP_RUNNING_PID=$!

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use . && gem install bundler && bundle
#TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/*
TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/bootstrap_with_aud* features/bootstrap_with_service_identifier.feature features/auditing_* features/se* features/bootstrap_with_env*.feature
#TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/sessions.feature:6
TEST_EXIT_CODE=$?

echo "Stopping keep_running script and soar_sc service instance"
kill $KEEP_RUNNING_PID
$SOAR_DIR/stop.sh

echo "Exiting with status code $TEST_EXIT_CODE"
cd $BASE_DIR
exit $TEST_EXIT_CODE
