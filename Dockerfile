FROM golang:alpine as builder

COPY . /go/src/shortLink/

WORKDIR /go/src/shortLink/

RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.8/main"  /etc/apk/repositories \
 && echo "http://mirrors.ustc.edu.cn/alpine/v3.8/community" >> /etc/apk/repositories

RUN apk update && apk --no-cache add git \
  && go get \
  && go build -v -o /go/src/shortLink/main /go/src/shortLink/main.go

FROM alpine:latest

COPY --from=builder /go/src/shortLink/main \
   /go/src/shortLink/show.html \
   /go/src/shortLink/index.html \
   /app/

WORKDIR /app

RUN chmod +x /app/main

EXPOSE 8000

CMD ["./main"]