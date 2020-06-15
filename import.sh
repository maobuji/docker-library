#!/bin/bash

images=(
k8s.gcr.io/pause:3.1=registry.cn-shenzhen.aliyuncs.com/maobuji/pause:3.1
k8s.gcr.io/metrics-server-amd64:v0.2.1=registry.cn-shenzhen.aliyuncs.com/maobuji/metrics-server-amd64:v0.2.1
docker.io/kubernetesui/dashboard:v2.0.0=registry.cn-shenzhen.aliyuncs.com/maobuji/kubernetesui-dashboard:v2.0.0
)

OIFS=$IFS; # 保存旧值
for image in ${images[@]};do
    IFS='='
    set $image
    docker pull $2
    docker tag  $2 $1
    docker rmi  $2
    docker save $1 > 1.tar && microk8s.ctr i import 1.tar && rm 1.tar
    IFS=$OIFS; # 还原旧值
done