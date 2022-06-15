FROM 172.18.31.155/kubernetes/trochilus-base:latest

WORKDIR /trochilus

RUN apt update \
    && apt install git  python3-libvirt gcc python3-rados python3-dev python3-rbd  pciutils ceph-common ipmitool -y \
    && apt install python3-pip dnsmasq dnsmasq-utils -y \
    && touch /var/log/trochilus/trochilus-agent.log \
    && cp etc/trochilus/trochilus.conf.sample /etc/trochilus/trochilus.conf \
    && pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple \
    && pip3 install simplejson \
    && python3 setup.py install \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


CMD ["trochilus-agent", "--config-file","/etc/trochilus/trochilus.conf"]
