FROM rust:latest as builder
ENV APP task-tracker
WORKDIR /usr/src/$APP
COPY . .
RUN cargo install --path .
 
FROM debian:buster-slim
RUN apt-get update && apt-get -y install ca-certificates && update-ca-certificates  &&  rm -rf /var/lib/apt/lists/* 
# RUN apt-get install -y ca-certificates
# RUN update-ca-certificates
COPY --from=builder /usr/local/cargo/bin/$APP /usr/local/bin/$APP
#export this actix web service to port 8080 and 0.0.0.0
EXPOSE 8080
CMD ["task-tracker"]

# run docker: docker run -v ${HOME}/.aws/credentials:/root/.aws/credentials:ro -p 8080:8080 tasktracker