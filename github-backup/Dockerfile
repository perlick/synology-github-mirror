FROM public.ecr.aws/ubuntu/ubuntu:22.04_stable

RUN apt update && \
	apt install gh -y && \
	apt install git -y && \
	apt install cron -y

WORKDIR /github-backup

COPY . .

RUN echo '0,5,10,15,20,25,30,35,40,45,50,55 * * * 0-6 GH_TOKEN=$GH_TOKEN /github-backup/src/main.sh > /proc/1/fd/1 2>&1 ' | crontab
