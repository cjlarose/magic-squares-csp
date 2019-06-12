FROM openjdk:11.0-stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
  libgmp10 \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/conjure.zip https://github.com/conjure-cp/conjure/releases/download/v2.2.0/conjure-v2.2.0-linux.zip \
  && unzip /tmp/conjure.zip -d /tmp \
  && mv /tmp/conjure-v2.2.0-linux/conjure /usr/local/bin \
  && rm -rf /tmp/conjure.zip /tmp/conjure-v2.2.0-linux

RUN curl -L -o /tmp/savilerow.tar.gz https://savilerow.cs.st-andrews.ac.uk/savilerow-1.7.0RC-linux.tgz \
  && tar -C /tmp -xf tmp/savilerow.tar.gz \
  && mkdir /opt/savilerow \
  && cd /tmp/savilerow-1.7.0RC-linux \
  && mv savilerow savilerow.jar COPYING LICENSES bin /opt/savilerow \
  && rm -rf /tmp/savilerow-1.7.0RC-linux

ENV PATH="/opt/savilerow:${PATH}"
