FROM rust:latest as builder
ENV APP task-tracker

WORKDIR /usr/src/$APP
# COPY $HOME/.aws/credentials /root/.aws/credentials
COPY . .
# COPY /Users/monarch/.aws/credentials ~/.aws/credentials
RUN cargo install --path .

FROM debian:buster-slim
# ENV HOME /Users/monarch
ENV APP task-tracker
RUN apt-get update && apt-get -y install ca-certificates && update-ca-certificates && rm -rf /var/lib/apt/lists/* 
# RUN apt-get install -y ca-certificates
# RUN update-ca-certificates

COPY --from=builder /usr/local/cargo/bin/$APP /usr/local/bin/$APP
# RUN ls
COPY --from=builder /usr/src/$APP/credentials /root/.aws/credentials
# COPY /usr/src/task-tracker.env .
#export this actix web service to port 8080 and 0.0.0.0
EXPOSE 8080
CMD ["task-tracker"]

# run docker: docker run -v ${HOME}/.aws/credentials:/root/.aws/credentials:ro -p 8080:8080 tasktracker