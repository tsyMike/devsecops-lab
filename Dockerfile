FROM python:3.11-alpine

WORKDIR /app

# Crear usuario y grupo sin privilegios en Alpine
RUN addgroup -S appuser && adduser -S appuser -G appuser

COPY app/ /app/
RUN pip install --no-cache-dir -r requirements.txt

# Asignar usuario no-root
USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/buscar')" || exit 1

CMD ["python", "app.py"]
