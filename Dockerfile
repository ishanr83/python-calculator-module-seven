FROM python:3.12-slim-bullseye
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN useradd -m appuser && mkdir -p logs history && chown -R appuser:appuser /app
COPY --chown=appuser:appuser . .
USER appuser
ENTRYPOINT ["python","-m","app"]
CMD ["help"]
