FROM gitpod/workspace-postgres
                    
USER gitpod

ENV PATH="$PATH:/usr/lib/postgresql/$(ls /usr/lib/postgresql/ | head -n 1)/bin"

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
