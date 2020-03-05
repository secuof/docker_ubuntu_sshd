FROM ubuntu:latest
MAINTAINER David Hong <secuof@gmail.com>

RUN apt-get update
RUN apt-get install -y curl wget apt-utils
RUN wget -O /root/change_ubuntu_mirror.sh https://gist.githubusercontent.com/secuof/afe8c6a121c22fefe1e28d0243bc7bee/raw/
RUN bash /root/change_ubuntu_mirror.sh
RUN apt-get update
RUN apt-get install -y vim apt-transport-https openssh-server python3 python3-pip jq gettext bash-completion

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash secuof

#set password
RUN echo 'root:root' |chpasswd
RUN echo 'secuof:secuof' |chpasswd

#replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#make .ssh
RUN mkdir /root/.ssh
RUN mkdir /home/secuof/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
