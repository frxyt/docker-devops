FROM debian:bookworm-slim
LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Paris

RUN set -ex; \
    apt-get update; \
    apt-get install -y --fix-missing --no-install-recommends \
        apache2-utils \
        apg \
        apt-transport-https \
        bash-completion \
        build-essential \
        ca-certificates \
        curl \
        default-mysql-client \
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
        postgresql-client \
        postgresql-client-common \
        procps \
        pwgen \
        python3 \
        python3-pip \
        python3-venv \
        rclone \
        rename \
        rsync \
        software-properties-common \
        sudo \
        unzip \
        vim \
        wget \
        whois; \
    apt-get clean -y; \
    apt-get autoclean -y; \
    rm -r /var/lib/apt/lists/*;

RUN set -ex; \
    python3 -m venv /opt/ansible-pyvenv; \
    /opt/ansible-pyvenv/bin/python3 -m pip install --upgrade pip; \
    /opt/ansible-pyvenv/bin/pip3 install \
        ansible \
        ansible-cmdb \
        ansible-lint[yamllint] \
        ansible-nwd \
        j2cli[yaml] \
        molecule[docker,lint] \
        netaddr \
        paramiko \
        s3cmd \
        yq; \
    ln -s /opt/ansible-pyvenv/bin/an*   /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/b*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/j*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/m*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/n*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/s*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/t*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/x*    /usr/local/bin; \
    ln -s /opt/ansible-pyvenv/bin/y*    /usr/local/bin;

RUN set -ex; \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list; \
    apt-get update; \
    apt-get install -y --fix-missing --no-install-recommends \
        docker-ce-cli \
        docker-compose-plugin; \
    apt-get clean -y; \
    apt-get autoclean -y; \
    rm -r /var/lib/apt/lists/*;

RUN set -ex; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update; \
    apt-get install -y --fix-missing --no-install-recommends \
        terraform \
        vault; \
    apt-get clean -y; \
    apt-get autoclean -y; \
    rm -r /var/lib/apt/lists/*;

RUN set -ex; \
    groupadd -g 1000 devops; \
    useradd -g 1000 -ms /bin/bash -u 1000 devops; \
    groupadd -r docker; \
    adduser devops docker; \
    adduser devops sudo; \
    echo 'devops ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/devops; \
    mkdir -p /home/devops/.ssh; \
    chown devops:devops -R /home/devops;
USER devops
WORKDIR /work

ENV LOAD_SSH_PRIVATE_KEY_1=/home/devops/.ssh/id_rsa \
    LOAD_SSH_PRIVATE_KEY_2=/home/devops/.ssh/id_dsa \
    LOAD_SSH_PRIVATE_KEY_3=/home/devops/.ssh/id_ecdsa \
    LOAD_SSH_PRIVATE_KEY_4= \
    LOAD_SSH_PRIVATE_KEY_5= \
    LOAD_SSH_PRIVATE_KEY_6= \
    LOAD_SSH_PRIVATE_KEY_7= \
    LOAD_SSH_PRIVATE_KEY_8= \
    LOAD_SSH_PRIVATE_KEY_9=

COPY ./bin /usr/local/bin
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
CMD [ "bash" ]
