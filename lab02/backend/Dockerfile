FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "uvicorn", "main:app", "--reload"] 
CMD ["--port", "5000", "--host", "0.0.0.0"]
EXPOSE 5000