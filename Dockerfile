FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN echo 'Match User root' >> /etc/ssh/sshd_config \
  && echo '  ChrootDirectory /var/www/' >> /etc/ssh/sshd_config \
  && echo '  ForceCommand internal-sftp' >> /etc/ssh/sshd_config \
  && echo '  AuthorizedKeysFile /etc/ssh/authorized_keys/%u' >> /etc/ssh/sshd_config \
  && echo '  X11Forwarding no' >> /etc/ssh/sshd_config \
  && echo '  AllowTcpForwarding no' >> /etc/ssh/sshd_config

ADD ./run.sh /run.sh

EXPOSE 22
CMD ["/run.sh"]

