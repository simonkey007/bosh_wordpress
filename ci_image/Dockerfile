FROM teamidefix/credentials-generator

RUN apt-get update && \
    apt-get -y install curl wget bzr git unzip ruby ruby-dev \
        libxml2-dev libxslt-dev libcurl4-openssl-dev \
        build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev postgresql-client

ADD https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64.zip /tmp/
RUN unzip -o /tmp/spiff_linux_amd64.zip -d /usr/local/bin
RUN rm /tmp/spiff_linux_amd64.zip

RUN gem install bundler --no-rdoc --no-ri
RUN gem install bosh_cli -v 1.3184.1.0 --no-rdoc --no-ri

ADD cf-cli/cf-linux-amd64.tgz /usr/bin/
ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/bin/jq
RUN chmod 775 /usr/bin/jq

# Install Go
RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN go get github.com/bronze1man/yaml2json
RUN go get github.com/cloudfoundry-community/humanize-manifest
