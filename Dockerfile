# syntax=docker/dockerfile:1.4

# Stage 1: Build stage
FROM python:3.7-alpine AS builder

WORKDIR /app

# Install build dependencies for Python packages
RUN apk add --no-cache gcc musl-dev linux-headers postgresql-dev

COPY requirements.txt /app
RUN pip3 install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Final runtime stage
FROM python:3.7-alpine

WORKDIR /app

# Copy only the installed packages from the builder stage
COPY --from=builder /install /usr/local

# Copy the rest of the application code
COPY . /app

# Expose the application port
EXPOSE 8000

# Run the Django development server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
