#!/bin/bash
set -e

releases=$(mktemp /tmp/releases.XXXXXX)
stemcells=$(mktemp /tmp/stemcells.XXXXXX)

curl -s -k --user ${BOSH_USER}:${BOSH_PASSWORD} ${BOSH_TARGET}/releases > ${releases}
curl -s -k --user ${BOSH_USER}:${BOSH_PASSWORD} ${BOSH_TARGET}/stemcells > ${stemcells}

release_name="wordpress"
release_version="1.0"
release_url=""

cd git-repo

bosh -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} create release --name ${release_name} --version ${release_version}

exists="$(cat $releases | jq -r 'map(select(.name == "'${release_name}'")) | .[].release_versions | map(select(.version == "'${release_version}'")) | length')"
if [ "${exists}" == "0" ] || [ "${exists}" == "" ]; then
  if [[ ${release_url} =~ /bosh\.io/ ]]; then
    bosh --non-interactive -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} upload release "${release_url}?v=${release_version}"
  else
    bosh --non-interactive -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} upload release dev_releases/${release_name}/${release_name}-${release_version}.yml
  fi
fi

stemcell_name="bosh-warden-boshlite-ubuntu-trusty-go_agent"
stemcell_version="3147"
stemcell_url="https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent"

exists="$(cat ${stemcells} | jq -r 'map(select(.name == "'${stemcell_name}'" and .version == "'${stemcell_version}'")) | length')"
if [ "${exists}" == "0" ] || [ "${exists}" == "" ]; then
  bosh --non-interactive -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} upload stemcell "${stemcell_url}\?v\=${stemcell_version}"
fi

bosh target ${BOSH_TARGET}
bosh --non-interactive -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} deployment examples/wordpress.yml
bosh --non-interactive -t ${BOSH_TARGET} -u ${BOSH_USER} -p ${BOSH_PASSWORD} deploy
