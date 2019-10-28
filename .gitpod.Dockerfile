FROM docker:dind-rootless

USER root

RUN apk add --no-cache sudo

### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN adduser -u 33333 -g gitpod -h /home/gitpod --shell /bin/bash --disabled-password gitpod && adduser gitpod daemon && addgroup sudo && adduser gitpod sudo && \
    sed -i.bkp -e 's/# %sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
RUN cat /etc/sudoers | grep NOPASSWD
ENV HOME=/home/gitpod
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc

USER gitpod
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success"

USER root