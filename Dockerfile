# FROM gcr.io/go-containerregistry/crane:debug as crane
FROM ubuntu:focal-20220826

RUN apt-get update -y && \
    apt-get -yq install curl wget gnupg2 lsb-release software-properties-common && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

# install the vault
RUN curl https://apt.releases.hashicorp.com/gpg --output /tmp/gpg_key && \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add /tmp/gpg_key && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main" && \
    apt-get update -y && \
    apt-get -yq install vault jq && \
    setcap -r /usr/bin/vault && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

# verify that the vault works
RUN vault -h

# install GO
RUN curl -OL https://go.dev/dl/go1.19.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xvf go1.19.1.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin

# test Go
RUN go version

# install crane in Go
RUN go install github.com/google/go-containerregistry/cmd/crane@latest

# test crane
RUN crane version


# install ECR-Login helper (see https://github.com/awslabs/amazon-ecr-credential-helper/releases)
RUN wget https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.6.0/linux-amd64/docker-credential-ecr-login && \
    chmod +x ./docker-credential-ecr-login && \
    mv docker-credential-ecr-login /usr/local/bin

