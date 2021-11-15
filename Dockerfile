FROM debian:bullseye-slim
LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Paris

RUN set -ex; \
    apt-get update; \
    apt-get install -y --fix-missing --no-install-recommends \
        apache2-utils \
        apt-transport-https \
        build-essential \
        curl \
        dnsutils \
        figlet \
        git \
        gnupg2 \
        jq \
        keychain \
        less \
        locate \
        man \
        nano \
        openssh-client \
        procps \
        python3 \
        python3-pip \
        rename \
        rsync \
        software-properties-common \
        vim \
        wget \
        whois; \
    apt-get clean -y; \
    apt-get autoclean -y; \
    rm -r /var/lib/apt/lists/*;

RUN set -ex; \
    pip3 install \
        ansible \
        ansible-cmdb \
        ansible-lint[yamllint] \
        ansible-nwd \
        molecule[docker,lint] \
        netaddr \
        paramiko \
        yq;

RUN set -ex; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -; \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"; \
    apt-get update; \
    apt-get install -y --fix-missing --no-install-recommends \
        terraform; \
    apt-get clean -y; \
    apt-get autoclean -y; \
    rm -r /var/lib/apt/lists/*;

RUN set -ex; \
    groupadd -g 1000 debian; \
    useradd -g 1000 -ms /bin/bash -u 1000 debian;
USER debian
WORKDIR /work

ENV LOAD_SSH_PRIVATE_KEY_1=/home/debian/.ssh/id_rsa \
    LOAD_SSH_PRIVATE_KEY_2=/home/debian/.ssh/id_dsa \
    LOAD_SSH_PRIVATE_KEY_3=/home/debian/.ssh/id_ecdsa \
    LOAD_SSH_PRIVATE_KEY_4= \
    LOAD_SSH_PRIVATE_KEY_5= \
    LOAD_SSH_PRIVATE_KEY_6= \
    LOAD_SSH_PRIVATE_KEY_7= \
    LOAD_SSH_PRIVATE_KEY_8= \
    LOAD_SSH_PRIVATE_KEY_9=

COPY ./entrypoint /usr/local/bin/frx-entrypoint
ENTRYPOINT [ "/usr/local/bin/frx-entrypoint" ]
CMD [ ]