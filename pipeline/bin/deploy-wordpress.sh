#!/bin/bash
set -e

cd git-repo

bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD create release --name wordpress --version 1.0
bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD upload release dev_releases/wordpress/wordpress-1.0.yml
bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3147
bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD deployment examples/wordpress.yml
bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD deploy


#bosh --non-interactive --target $BOSH_TARGET --user $BOSH_USER --password $BOSH_PASSWORD upload release "${release_url}?v=${release_version}"
