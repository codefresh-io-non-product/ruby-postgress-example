#!/usr/bin/env bash

set -e
cd /usr/app/dir/

redis-server &

/etc/init.d/postgresql start \
    && RAILS_ENV=development rails s -p 3000