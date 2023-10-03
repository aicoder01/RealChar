FROM python:3.10-bullseye

# 安装系统级依赖项和 SQLite3 版本
RUN apt-get update && apt-get install -y build-essential portaudio19-dev libffi-dev libssl-dev ffmpeg libpq-dev

WORKDIR /realtime_ai_character

# 安装 Python 依赖项
COPY requirements.txt /realtime_ai_character/
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY ./ /realtime_ai_character/

# 暴露容器中的 8000 端口
EXPOSE 8000

# 使入口脚本可执行
RUN chmod +x /realtime_ai_character/entrypoint.sh

# 运行应用程序
CMD ["/bin/sh", "/realtime_ai_character/entrypoint.sh"]
