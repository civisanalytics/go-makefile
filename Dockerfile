FROM ubuntu:14.04

RUN apt-get update -y && apt-get install --no-install-recommends -y -q \
                         curl build-essential ca-certificates git mercurial bzr \
                      && rm -rf /var/lib/apt/lists/*

ENV GOVERSION 1.5.4

ENV GOROOT /goroot
ENV GOPATH /gopath

RUN mkdir $GOROOT $GOPATH
ENV PATH $GOROOT/bin:$GOPATH/bin:/opt:$PATH

RUN curl -L https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz \
    | tar xzf - -C $GOROOT --strip-components=1

RUN go get github.com/mitchellh/gox

RUN curl -L https://github.com/github/hub/releases/download/v2.2.2/hub-linux-amd64-2.2.2.tgz \
    | tar xzf - -C /opt --strip-components=2 hub-linux-amd64-2.2.2/bin/hub

CMD gox
