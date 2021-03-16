FROM ubuntu:focal

RUN apt-get update -y
COPY DeadlineClient-*-linux-x64-installer.run DeadlineClient-installer.run
RUN chmod u+x DeadlineClient-installer.run && \
	./DeadlineClient-installer.run \
	--binariesonly true \
	--mode unattended

FROM ubuntu:focal
# RUN apt-get update -y && apt-get install curl -y
COPY --from=0 /opt/Thinkbox /opt/Thinkbox
COPY run.sh .

CMD ["./run.sh","deadline.exe"]
