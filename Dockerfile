FROM golang:1.15.3-alpine AS build

WORKDIR /src/
COPY . ./
RUN go get
RUN go build -o /bin/mtr_exporter

FROM alpine:latest

COPY --from=build /bin/mtr_exporter /bin/mtr_exporter
COPY mtr.yaml /target/mtr.yaml
RUN apk add --no-cache mtr
EXPOSE 9116
CMD ["/bin/mtr_exporter"]