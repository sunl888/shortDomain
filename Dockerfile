FROM golang:alpine as builder

COPY . /go/src/shortLink/
COPY source.list /etc/apk/repositories
WORKDIR /go/src/shortLink/
RUN apk update \
  && apk --no-cache add git \
  && go get \
  && go build -v -o /go/src/shortLink/main /go/src/shortLink/main.go



FROM alpine:latest

COPY --from=builder /go/src/shortLink/   /app/
WORKDIR /app
RUN chmod +x /app/main
EXPOSE 8000
CMD ["./main"]