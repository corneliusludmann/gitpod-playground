FROM  gitpod/workspace-full
USER root

# Install custom tools, runtime, etc.
RUN sudo apt update && \
    sudo apt install -y shellcheck \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && sudo mv kubectl /usr/local/bin/kubectl && sudo chmod 755 /usr/local/bin/kubectl \
    && wget https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz \
    && tar zxvf helm-v3.2.4-linux-amd64.tar.gz \
    && sudo mv linux-amd64/helm /usr/local/bin/helm3 \
    && sudo chmod 755 /usr/local/bin/helm3 \
    && sudo apt install -y xdg-utils \
    && curl https://get.okteto.com -sSfL | sh \
    && sudo apt-get -y update \
    && sudo apt-get -y install \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable" \
    && sudo apt-get -y update \
    && sudo apt-get -y install docker-ce \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  \
    && sudo apt -y install ./google-chrome-stable_current_amd64.deb \
    && npm install -g graphqurl \
    && sudo rm -rf /var/lib/apt/lists/* 

USER gitpod
