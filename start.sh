#!/usr/bin/env bash

set -e
cd /usr/app/dir/

redis-server &

/etc/init.d/postgresql start \
    && RAILS_ENV=development rails s -b0.0.0.0 -p 8081