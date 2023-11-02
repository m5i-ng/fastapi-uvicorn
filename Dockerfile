FROM python:3.9
WORKDIR /app
COPY ./app /app
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
ENTRYPOINT ["/bin/bash", "/app/docker-entry.sh"]
