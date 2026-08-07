import os
import time
from flask import Flask, jsonify, request
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# Métricas de Prometheus (Estándar DevSecOps / Observabilidad)
REQUEST_COUNT = Counter(
    'http_requests_total',
    'Total de peticiones HTTP procesadas',
    ['method', 'endpoint', 'http_status']
)

REQUEST_LATENCY = Histogram(
    'http_request_duration_seconds',
    'Latencia de las peticiones HTTP en segundos',
    ['endpoint']
)


@app.route('/')
def root():
    start_time = time.time()

    response_data = {
        "service": "devops-portfolio-api",
        "version": "1.0.0",
        "status": "running",
        "environment": "development"
    }

    duration = time.time() - start_time
    REQUEST_LATENCY.labels(endpoint='/').observe(duration)
    REQUEST_COUNT.labels(method=request.method, endpoint='/', http_status='200').inc()

    return jsonify(response_data), 200


@app.route('/health')
def health():
    """Endpoint para Kubernetes liveness/readiness probes"""
    REQUEST_COUNT.labels(method=request.method, endpoint='/health', http_status='200').inc()

    return jsonify({
        "status": "healthy",
        "checks": {
            "database": "n/a",
            "uptime": "ok"
        }
    }), 200


@app.route('/metrics')
def metrics():
    """Endpoint scrapeado por Prometheus"""
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)