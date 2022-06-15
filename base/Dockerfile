FROM ubuntu:20.04

# LABEL maintainer="Kolla Project (https://launchpad.net/kolla)" name="base" build-date="20220415"


RUN . /etc/os-release;\
    if [ "${PRETTY_NAME#Ubuntu 20.04}" = "$PRETTY_NAME" ]; then \
        echo "Only releases \"Ubuntu 20.04\" are supported on ubuntu"; false; \
    fi

# We use curl in this dockerfile so let configure it before first use
COPY curlrc /root/.curlrc


# NOTE(yoctozepto): use a UTF-8 (Unicode) locale like standard image installs do
# fixes issues arising from ascii fallback usage
ENV LANG en_US.UTF-8


RUN groupadd --gid 42401 ansible \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42401 --gid 42401 ansible \
    && groupadd --gid 42412 elasticsearch \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42412 --gid 42412 elasticsearch \
    && groupadd --gid 42413 etcd \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42413 --gid 42413 etcd \
    && groupadd --gid 42454 haproxy \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42454 --gid 42454 haproxy \
    && groupadd --gid 42423 kafka \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42423 --gid 42423 kafka \
    && groupadd --gid 42426 kibana \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42426 --gid 42426 kibana \
    && groupadd --gid 42400 kolla \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42400 --gid 42400 kolla \
    && groupadd --gid 42473 libvirt \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42473 --gid 42473 libvirt \
    && groupadd --gid 42432 mongodb \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42432 --gid 42432 mongodb \
    && groupadd --gid 42434 mysql \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42434 --gid 42434 mysql \
    && groupadd --gid 42476 openvswitch \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42476 --gid 42476 openvswitch \
    && groupadd --gid 42472 prometheus \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42472 --gid 42472 prometheus \
    && groupadd --gid 42427 qemu \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42427 --gid 42427 qemu \
    && groupadd --gid 42439 rabbitmq \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42439 --gid 42439 rabbitmq \
    && groupadd --gid 42460 redis \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42460 --gid 42460 redis \
    && groupadd --gid 42447 td-agent \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42447 --gid 42447 td-agent \
    && groupadd --gid 42829 emqx \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42829 --gid 42829 emqx \
    && groupadd --gid 42831 troila \
    && useradd -l -M --shell /usr/sbin/nologin --uid 42831 --gid 42831 troila

COPY kolla_bashrc /tmp/
RUN cat /tmp/kolla_bashrc >> /etc/skel/.bashrc \
    && cat /tmp/kolla_bashrc >> /root/.bashrc

ENV PS1="$(tput bold)($(printenv KOLLA_SERVICE_NAME))$(tput sgr0)[$(id -un)@$(hostname -s) $(pwd)]$ "


RUN cat /tmp/kolla_bashrc >> /etc/bash.bashrc \
    && sed -i -e s/LAST_SYSTEM_UID=999/LAST_SYSTEM_UID=59999/g \
              -e s/LAST_SYSTEM_GID=999/LAST_SYSTEM_GID=59999/g /etc/adduser.conf

# This will prevent questions from being asked during the install
ENV DEBIAN_FRONTEND noninteractive

# Reducing disk footprint
COPY dpkg_reducing_disk_footprint /etc/dpkg/dpkg.cfg.d/dpkg_reducing_disk_footprint


# curl and ca-certificates to fetch remote keys via http
# gnupg to fetch keys directly from keyserver

# ubuntu-cloud-keyring to install UCA packages



RUN apt-get update && apt-get -y install --no-install-recommends ca-certificates curl gnupg ubuntu-cloud-keyring && apt-get clean && rm -rf /var/lib/apt/lists/*




COPY sources.list.ubuntu /etc/apt/sources.list



COPY apt_preferences.ubuntu /etc/apt/preferences



RUN mkdir -p /etc/kolla/apt-keys/ && gpg --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 F77F1EDA57EBB1CC && gpg --export F77F1EDA57EBB1CC >/etc/kolla/apt-keys/erlang.gpg \
    && gpg --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 F6609E60DC62814E && gpg --export F6609E60DC62814E >/etc/kolla/apt-keys/rabbitmq.gpg \
    && gpg --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 CFFB779AADC995E4F350A060505D97A41C61B9CD && gpg --export CFFB779AADC995E4F350A060505D97A41C61B9CD >/etc/kolla/apt-keys/haproxy.gpg
RUN mkdir -p /etc/kolla/apt-keys/  && curl https://artifacts.elastic.co/GPG-KEY-elasticsearch -o /etc/kolla/apt-keys/elasticsearch.asc \
    && curl https://packages.grafana.com/gpg.key -o /etc/kolla/apt-keys/grafana.asc \
    && curl https://repos.influxdata.com/influxdb.key -o /etc/kolla/apt-keys/influxdb.asc \
    && curl https://downloads.mariadb.com/MariaDB/mariadb-keyring-2019.gpg -o /etc/kolla/apt-keys/mariadb.gpg \
    && curl https://repo.proxysql.com/ProxySQL/repo_pub_key -o /etc/kolla/apt-keys/proxysql.asc \
    && curl https://packages.treasuredata.com/GPG-KEY-td-agent -o /etc/kolla/apt-keys/treasuredata.asc
    
RUN apt-get update \
    && apt-get -y install locales \
    && sed -e "s/# $LANG UTF-8/$LANG UTF-8/g" /etc/locale.gen -i \
    && locale-gen "$LANG" \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get update && apt-get -y install --no-install-recommends apt-utils dumb-init gawk iproute2 kmod lsof lvm2 netbase open-iscsi procps python3 python3-pip socat sudo tgt && apt-get clean && rm -rf /var/lib/apt/lists/*






