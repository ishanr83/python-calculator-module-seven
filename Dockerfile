FROM python:3.12-slim-bullseye

# App directory
WORKDIR /app

# Install deps first (better cache)
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Create non-root user & data dirs
RUN useradd -m appuser && mkdir -p logs history && chown -R appuser:appuser /app

# Copy source as non-root owner
COPY --chown=appuser:appuser . .

# Drop privileges
USER appuser

# Default command runs the calculator REPL; you can override with args
ENTRYPOINT ["python", "-m", "app"]
CMD ["help"]
