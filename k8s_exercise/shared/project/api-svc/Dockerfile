# This Dockerfile builds an image for the api-svc service, which is
# built with the Go programming language.
#
# The image is composed of two layers. The first layer is built
# using the golang:1.21.5-alpine3.19 image, which provides a minimal
# Go development environment. The second layer is a minimal
# Alpine Linux image.
#
# The first layer copies the go.mod file from the build context,
# and runs go mod tidy to initialize the module. The entire
# directory is then copied into the build layer, and the api-svc
# application is compiled in release mode.
#
# The second layer copies the compiled binary from the build layer,
# and exposes port 9090. The final command is to run the compiled
# binary, which starts the api-svc web server.
#
FROM golang:1.21.5-alpine3.19 AS builder
# Set working directory in the build layer
WORKDIR /app
# Copy go.mod file from build context
COPY go.mod . 
# Initialize module using go mod tidy
RUN go mod tidy
# Copy entire directory into build layer
COPY . .
# Compile application in release mode
RUN go build -o api-svc .

# Second layer: minimal Alpine Linux image
FROM alpine:3.19
# Set working directory in final layer
WORKDIR /app
# Copy compiled binary from build layer
COPY --from=builder /app/api-svc .
# Expose port 9090 for the api-svc web server
EXPOSE 9090
# Run compiled binary to start web server
CMD ["./api-svc"]
