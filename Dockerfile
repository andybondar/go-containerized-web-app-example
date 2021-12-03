# Build stage
FROM golang:1.16.10-alpine3.14 AS builder

RUN mkdir /app
COPY app/* /app/

WORKDIR /app
RUN go build -o /go-web-helloworld .

# Run stage
FROM alpine:3.14.3

COPY --from=builder /go-web-helloworld /go-web-helloworld
CMD ["/go-web-helloworld"]
EXPOSE 8080