# BOSH Wordpress Release

This is a sample release repository for [BOSH](https://github.com/cloudfoundry/bosh) that deploys a three tier LAMP application: a wordpress blog which consists of a number of apache servers running php & wordpress, fronted by nginx, and using one mysql database for storage.

## Deploying a wordpress release using BOSH

### INDEX

* [Deploy](#deploy)

### release contents

A BOSH release consists of jobs, packages, source code, and associated release metadata.  Large binary files (aka "blobs") required for packaging can be stored externally in a blobstore and referenced within the release, obviating the need to store them inside the release repository.  Additionally, in order to utilize a BOSH release you must create a deployment manifest.

For a more detailed explanation of BOSH terminology please refer to the [BOSH Reference](http://docs.cloudfoundry.com/docs/running/bosh/reference/).

#### Helpfull links

[jobs](http://docs.cloudfoundry.com/docs/running/bosh/reference/jobs.html)
[BOSH packages](http://docs.cloudfoundry.com/docs/running/bosh/reference/packages.html)
[packaging](http://docs.cloudfoundry.com/docs/running/bosh/reference/packages.html#package-compilation)
[nats message bus](http://docs.cloudfoundry.com/docs/running/bosh/components/messaging.html)
[monit](http://mmonit.com/monit/)
[ERB templates](http://www.stuartellis.eu/articles/erb/)

### <a id="deploy"></a>Deploy

To deploy the sample wordpress application edit the example deployment manifest (examples/wordpress.yml) and adapt it with your data. Make sure you have installed Vagrant version 1.7.4. Then use the following command sequence:
    bosh create release --force
    bosh upload release dev_releases/wordpress/wordpress-0+dev.1.yml
    bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent\?v\=3147
    bosh deployment examples/wordpress.yml
    bosh deploy
