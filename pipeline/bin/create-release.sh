#!/bin/bash
set -e
bosh target 192.168.50.4 lite
bosh login admin admin
bosh create release --name wordpress --version 1.0
bosh upload release
bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3147
bosh deployment examples/wordpress.yml
bosh deploy
