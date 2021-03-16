FROM ubuntu:focal
RUN apt-get update -y && apt-get install libssl-dev -y
COPY DeadlineRepository-*-linux-x64-installer.run .
COPY run.sh .

CMD ./run.sh