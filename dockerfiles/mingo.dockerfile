FROM debian:stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
  bc \
  curl \
  ca-certificates \
  m4 \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN curl -o /tmp/mingo.tar.gz https://research.ics.aalto.fi/software/asp/mingo/mingo-2012-09-30.tgz \
  && tar -zx -C /opt -f /tmp/mingo.tar.gz \
  && cd /opt/mingo/bin \
  && ./wget-gringo.sh

ENV PATH="/opt/mingo:${PATH}"

WORKDIR /opt/mingo
