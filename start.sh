#!/bin/sh

# 1. 自动替换配置文件中的密码
sed -i "s/PASTE_YOUR_UUID_HERE/$UUID/g" config.json

# 2. 让 sing-box 在后台静默运行
sing-box run -c config.json > /dev/null 2>&1 &

# 3. 核心修复：前台挂载 Cloudflare Tunnel，死锁进程，防止容器闪退
exec cloudflared tunnel --no-autoupdate run --token $ARGO_TOKEN
