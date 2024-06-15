FROM golang:1.22.0 as builder

WORKDIR /build-app
COPY ./cmd/* ./
RUN go mod download 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./app

FROM alpine:3.20
WORKDIR /
COPY --from=builder /build-app/app .
COPY *.db .
CMD ["/app"]
