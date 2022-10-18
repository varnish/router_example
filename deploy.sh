#!/bin/bash
export VARNISH_CONTROLLER_CLI_PASSWORD=test
vcli='docker run --mount source=router_example,target=/home/varnish/ --network router_example_default --rm -it quay.io/varnish-software/varnish-controller-cli:latest'
vcli login http://api.example.com:8002 -u test
vcli tag add prod
vcli agent tag 1,2 -t 1 -y
vcli file add web.vcl web.vcl
vcli domain add mysite.example.com
vcli dep add prod -t 1 --max 2
vcli rr add video --lookup-order=random --http --health-path=/ping --health-interval=1s --debug-headers=true --health-timeout 1s --health-window-size 3 --health-threshold 2
vcli vg add mysite --dep 1 --rr 1 --vcl 1 --dom 1
vcli vg deploy 1
