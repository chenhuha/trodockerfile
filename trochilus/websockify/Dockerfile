FROM 172.18.31.155/kubernetes/trochilus-base:latest

WORKDIR /trochilus

RUN apt update \
    && apt install git  python3-libvirt gcc python3-rados python3-dev python3-rbd -y \
    && apt install python3-pip -y \
    && cp etc/trochilus/trochilus.conf.sample /etc/trochilus/trochilus.conf \
    && pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple \
    && pip3 install simplejson \
    && python3 setup.py install \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install websockify -i https://mirrors.aliyun.com/pypi/simple

#CMD ["websockify","--token-plugin","trochilus.websockify.token_plugin.Base64JsonTokenRemoteApi"]
