FROM python:3.5-alpine
MAINTAINER Alexey Diyan <alexey.diyan@gmail.com><Paste>

# py-setproctitle workaround: https://github.com/dvarrazzo/py-setproctitle/issues/44
RUN set -x \
  && buildDeps='postgresql-dev build-base openssl' \
  && apk add --update libpq $buildDeps \
  && wget -O /tmp/py-setproctitle.tar.gz https://github.com/dvarrazzo/py-setproctitle/archive/version-1.1.9.tar.gz \
  && tar -xzvf /tmp/py-setproctitle.tar.gz -C /tmp \
  && cd /tmp/py-setproctitle-version-1.1.9/ \
  && sed -i 's:#include <linux/prctl.h>://#include <linux/prctl.h>:' ./src/spt_status.c \
  && python setup.py install \
  && pip install pgcli==1.10.3 \
  && apk del $buildDeps \
  && rm -rf /var/cache/apk/* /tmp/py-setproctitle*

# a volume for:
# 1 pgcli-config
# 2 pgcli-log
# 3 pgcli-hisory
VOLUME /root/.config/pgcli

ENTRYPOINT ["/usr/local/bin/pgcli"]
CMD ["--help"]
