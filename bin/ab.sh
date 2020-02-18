#!/bin/bash

unset http_proxy https_proxy

n=100000

for (( i = 0; i < n; i++ )); do
    curl 127.0.0.1:8282/user/"$i"
done

wait

exit