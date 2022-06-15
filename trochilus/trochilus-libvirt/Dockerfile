FROM 172.18.31.155/kolla/trochilus-base:test

COPY deb/ /opt/

RUN mkdir -p /etc/vdi/ \
    && apt update \
    && apt install git  libx264-155 libvirt-daemon-system  libvirt-clients python3-libvirt gcc python3-rados python3-dev python3-rbd -y \
    && dpkg -i /opt/*.deb \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY libyuv.so /lib/libyuv.so

COPY libiniparser.so.1 /usr/lib/libiniparser.so.1

RUN ln -s /usr/lib/libiniparser.so.1 /usr/lib/libiniparser.so

COPY ./ovmf/* /usr/share/OVMF/

COPY ./qemu-firmware/* /usr/share/qemu/firmware/

COPY ./start.sh /usr/bin/start.sh

RUN chmod 755 /usr/bin/start.sh

CMD /usr/bin/start.sh

