FROM public.ecr.aws/ubuntu/ubuntu:22.04_stable

RUN apt update && \
	apt install systemd-journal-remote -y

WORKDIR /journal-log-server

COPY . .

