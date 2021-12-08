FROM docker:latest

RUN apk --update add --no-cache openssh bash \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && rm -rf /var/cache/apk/*

RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config

RUN /usr/bin/ssh-keygen -A

RUN ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_key

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]