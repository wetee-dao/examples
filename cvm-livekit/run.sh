#!/bin/sh

# 定义包含特殊字符的多行环境变量
special_text="port: $ser_port
rtc:
    udp_port: $udp_port
    tcp_port: $tcp_port
    use_external_ip: true
    enable_loopback_candidate: false
keys:
    APITnzNEjYyh5VB: 160fDb8raaVh6q292VjhVOZq6lKIWBxaRpm5nAQqEuU
logging:
    json: false
    level: info"

# 将包含特殊字符的多行环境变量写入文件
echo "$special_text" > livekit.yaml

/livekit-server --config /livekit.yaml