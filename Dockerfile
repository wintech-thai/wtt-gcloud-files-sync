FROM ruby:3.0

RUN apt-get update -y
RUN apt-get install -y cron wget curl zip unzip vim apt-transport-https ca-certificates gnupg lsb-release 

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install google-cloud-cli -y

WORKDIR /scripts
COPY scripts/ .

COPY crontab /etc/cron.d/crontab

RUN chmod 0644 /etc/cron.d/crontab
RUN touch /var/log/cron.log

# Start the cron service
CMD cron && tail -f /var/log/cron.log
