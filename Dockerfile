# 使用基础镜像 Python 3.10
FROM python:3.10-bullseye

# 安装系统级依赖项和 SQLite3 版本
RUN apt-get update && apt-get install -y build-essential portaudio19-dev libffi-dev libssl-dev ffmpeg libpq-dev
RUN apt-cache policy sqlite3

# 安装 Node.js v20.7.0 和 npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# 设置工作目录
WORKDIR /realtime_ai_character

# 复制项目文件
COPY ./ /realtime_ai_character/

# 复制 Python 依赖项清单并安装它们
COPY requirements.txt /realtime_ai_character/
RUN pip3 install --no-cache-dir -r requirements.txt

# 使入口脚本可执行
RUN chmod +x /realtime_ai_character/entrypoint.sh

# 运行构建命令（如果需要）
RUN python cli.py web-build

# 暴露容器中的 8000 端口
EXPOSE 10000

# 运行应用程序的入口脚本
CMD ["/bin/sh", "/realtime_ai_character/entrypoint.sh"]
