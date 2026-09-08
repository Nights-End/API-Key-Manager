# KeyHub — 无 apt,仅 pip(清华源),Web 模式
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

COPY key_manager/ key_manager/
COPY static/ static/
COPY templates/ templates/
COPY web.py main.py ./

RUN mkdir -p /app/data/input /app/data/cache /app/data/logs

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    KEY_MANAGER_DATA_DIR=/app/data

EXPOSE 18001

CMD ["python", "-m", "uvicorn", "key_manager.web:app", "--host", "0.0.0.0", "--port", "18001"]
