#!/bin/bash
set -e
cd git-repo
bosh -t https://192.168.50.4:25555 -u admin -p admin create release --name wordpress --version 1.0
bosh -t https://192.168.50.4:25555 -u admin -p admin upload release
bosh -t https://192.168.50.4:25555 -u admin -p admin upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3147
bosh -t https://192.168.50.4:25555 -u admin -p admin deployment examples/wordpress.yml
bosh -t https://192.168.50.4:25555 -u admin -p admin deploy
