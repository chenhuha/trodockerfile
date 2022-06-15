#!/bin/bash

trochilus-db-manage upgrade head

exec nohup trochilus-api --config-file /etc/trochilus/trochilus.conf --log-file /var/log/trochilus/trochilus-api.log