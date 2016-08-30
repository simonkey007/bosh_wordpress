#!/bin/bash
set -e

BOSH_TARGET="https://192.168.50.4:25555"
BOSH_USER="admin"
BOSH_PASSWORD="admin"

releases=$(mktemp /tmp/releases.XXXXXX)
stemcells=$(mktemp /tmp/stemcells.XXXXXX)

cd git-repo
bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD create release --name wordpress --version 1.0

curl -s -k --user $BOSH_USER:$BOSH_PASSWORD $BOSH_TARGET/releases > $releases
curl -s -k --user $BOSH_USER:$BOSH_PASSWORD $BOSH_TARGET/stemcells > $stemcells


	release_name="wordpress"
	release_version="1.0"
	release_url=""
	exists="$(cat $releases | jq -r 'map(select(.name == "'${release_name}'")) | .[].release_versions | map(select(.version == "'${release_version}'")) | length')"
	if [ "$exists" == "0" ] || [ "$exists" == "" ]; then
		if [[ ${release_url} =~ /bosh\.io/ ]]; then
			bosh --non-interactive --target $BOSH_TARGET --user $BOSH_USER --password $BOSH_PASSWORD upload release "${release_url}?v=${release_version}"
		else
			bosh --non-interactive --target $BOSH_TARGET --user $BOSH_USER --password $BOSH_PASSWORD upload release
		fi
	fi

  stemcell_name="bosh-warden-boshlite-ubuntu-trusty-go_agent"
  stemcell_version="3147"
  stemcell_url="https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3147"
  exists="$(cat $stemcells | jq -r 'map(select(.name == "'${stemcell_name}'" and .version == "'${stemcell_version}'")) | length')"
	if [ "$exists" == "0" ] || [ "$exists" == "" ]; then
		bosh --non-interactive --target $BOSH_TARGET --user $BOSH_USER --password $BOSH_PASSWORD upload stemcell "${stemcell_url}?v=${stemcell_version}"
	fi

bosh -t $BOSH_TARGET -u $BOSH_USER -p $BOSH_PASSWORD deploy examples/wordpress.yml
