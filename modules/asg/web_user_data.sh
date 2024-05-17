#!/bin/bash
# Amazon Linux 2 userdata script for setting up Nginx with ProxyPass

bash

# Update packages
sudo yum update -y

# Install Nginx
sudo yum install -y nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Configure ProxyPass in Nginx
cat << EOF > /etc/nginx/conf.d/proxy.conf
server {
    listen 80;
    server_name web.mycomet.link;

    # Proxy path configuration (e.g., /app)
    location /app {
        proxy_pass http://${alb_dns}/;
    }

    # Log settings (optional)
    error_log /var/log/nginx/mark_error.log;
    access_log /var/log/nginx/mark_access.log combined;
}

server {
    listen 443;
    server_name web.mycomet.link;

    # Proxy path configuration (e.g., /app)
    location /app {
        proxy_pass http://${alb_dns}/;
    }

    # Log settings (optional)
    error_log /var/log/nginx/mark_error.log;
    access_log /var/log/nginx/mark_access.log combined;
}
EOF

RZAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
IID=$(curl 169.254.169.254/latest/meta-data/instance-id)
LIP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)


cat << EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Web Server</title>
</head>
<body>
<h1>RegionAz(\$RZAZ) : Instance ID(\$IID) : Private IP(\$LIP) : Web Server</h1>
</body>
</html>
EOF

# Restart Nginx to apply changes
sudo systemctl restart nginx



# CloudWatch Agent 설치
sudo yum install -y amazon-cloudwatch-agent

# 에이전트 설정 파일 생성
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "cwagent"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/nginx/access.log",
            "log_group_name": "nginx-access-logs",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%d/%b/%Y:%H:%M:%S %z"
          }
        ]
      }
    }
  }
}
EOF

# IAM 역할이 CloudWatch에 로그를 보낼 권한을 부여했는지 확인하세요.

# CloudWatch Agent 실행
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s