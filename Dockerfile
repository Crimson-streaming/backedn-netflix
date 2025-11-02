FROM alpine:latest

RUN apk add --no-cache ca-certificates wget unzip

WORKDIR /app

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.26.3/pocketbase_0.26.3_linux_amd64.zip && unzip pocketbase_0.26.3_linux_amd64.zip && chmod +x pocketbase && rm pocketbase_0.26.3_linux_amd64.zip

RUN mkdir -p /app/pb_data

EXPOSE 8080

CMD ["./pocketbase", "serve", "--http=0.0.0.0:8080"]
