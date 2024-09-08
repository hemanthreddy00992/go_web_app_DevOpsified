FROM golang:1.22 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY .  .

RUN GOARCH=amd64 GOOS=linux go build -o webappmain .

#final stage as destroless image

FROM gcr.io/distroless/base

COPY --from=builder /app/webappmain .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "./webappmain" ]


