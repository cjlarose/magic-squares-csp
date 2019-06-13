FROM debian:stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/clingo.tar.gz https://github.com/potassco/clingo/releases/download/v5.3.0/clingo-5.3.0-linux-x86_64.tar.gz \
  && tar -zx -C /tmp -f /tmp/clingo.tar.gz \
  && cd /tmp/clingo-5.3.0-linux-x86_64 \
  && mv clasp clingo gringo lpconvert reify /usr/local/bin \
  && cd \
  && rm -rf /tmp/clingo.tar.gz /tmp/clingo-5.3.0-linux-x86_64
