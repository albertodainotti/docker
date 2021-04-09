ARG name
FROM $name

ARG distro
ARG distro-release
ARG user
ARG myflavor
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y install curl lsb-release sudo && \
  curl https://pkg.caida.org/os/${distro}/bootstrap.sh | bash

RUN if [ "${myflavor}" = "devel" ]; then apt-get -y update && apt-get install -y \
  apt-utils \
  build-essential \
  sudo \
  git \
  autoconf \
  libtool \
  vim \
  devscripts \
  ; fi

RUN useradd -m ${user} && echo "${user}:${user}" | chpasswd && adduser ${user} sudo
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

COPY bashrc /home/${user}/.bashrc
COPY bash_profile /home/${user}/.bash_profile
COPY gitconfig /home/${user}/.gitconfig
COPY install-deps /home/${user}/bin/install-deps

RUN mkdir /work && chown -R ${user}:${user} /work

USER ${user}
