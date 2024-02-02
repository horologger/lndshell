FROM alpine:latest
LABEL maintainer="horologger <horologger@protonmail.com>"
FROM horologger/gotty:v1.5.0

RUN apk update && \
    apk upgrade && \
    apk add screen && \
    apk add curl lsof jq vim && \
    apk add htop 

# RUN echo 'echo "gotty"' > /etc/hostname

RUN echo 'echo ""' > /root/.bashrc && \
    echo 'echo "Nothing is started in the background."' >> /root/.bashrc && \
    echo 'echo "Run htop command to display system info."' >> /root/.bashrc && \
    echo 'echo "Other commands: jq, vim, lsof, lncli"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc  && \
#    echo "export PS1='\h:\w\$ '" >> /root/.bashrc
    echo "export PS1='gotty:\w\$ '" >> /root/.bashrc

WORKDIR /root
ADD ./docker_entrypoint.sh /usr/bin/docker_entrypoint.sh
RUN chmod a+x /usr/bin/docker_entrypoint.sh

# Run docker_entrypoint.sh
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]