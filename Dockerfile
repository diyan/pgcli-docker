FROM alpine:3.3
MAINTAINER Alexey Diyan <alexey.diyan@gmail.com><Paste>

# py-setproctitle workaround: https://github.com/dvarrazzo/py-setproctitle/issues/44
RUN set -x \
  && buildDeps='py-pip python-dev postgresql-dev build-base openssl' \
  && apk add --update python py-setuptools libpq $buildDeps \
  && wget -O /tmp/py-setproctitle.tar.gz https://github.com/dvarrazzo/py-setproctitle/archive/version-1.1.9.tar.gz \
  && tar -xzvf /tmp/py-setproctitle.tar.gz -C /tmp \
  && cd /tmp/py-setproctitle-version-1.1.9/ \
  && sed -i 's:#include <linux/prctl.h>://#include <linux/prctl.h>:' ./src/spt_status.c \
  && python setup.py install \
  && pip install pgcli \
  && apk del $buildDeps \
  && rm -rf /var/cache/apk/* /tmp/py-setproctitle*

ENTRYPOINT ["/usr/bin/pgcli"]
