FROM alpine:latest

ARG SING_BOX_VERSION=1.10.1

# 安装基础依赖
RUN apk add --no-cache ca-certificates bash wget tar

WORKDIR /app

# 1. 下载并安装对应 amd64 架构的 sing-box
RUN wget https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    mv sing-box-${SING_BOX_VERSION}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf sing-box-${SING_BOX_VERSION}-linux-amd64*

# 2. 规范化下载官方 cloudflared 稳定版
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared

# 3. 复制代码并赋予权限
COPY . .
RUN chmod +x /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x start.sh

EXPOSE 8080

CMD ["./start.sh"]
