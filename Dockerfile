FROM golang:alpine as builder
COPY . /go/src/shortLink
RUN go build /go/src/shortLink /go/src/shortLink/*.go

FROM alpine:latest
COPY --from=builder /go/src/shortLink/main /app/main
WORKDIR /app
RUN chmod +x /app/main
CMD ["./main"]