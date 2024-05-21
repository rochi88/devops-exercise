FROM golang:1.21.5-alpine3.19 AS builder
WORKDIR /app
COPY go.mod . 
RUN go mod tidy
COPY . .
RUN go build -o api-svc .

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/api-svc .
EXPOSE 9090
CMD ["./api-svc"]