#!/usr/bin/env bash

set -e
cd /usr/app/dir/

export MONGODB_AUTH="$(date | md5sum | awk '{print $1}')"
export MONGO_DB="{{repoName}}"
export MONGO_URI="mongodb://$CF_USER_NAME:$MONGODB_AUTH@localhost:27017/$MONGO_DB"
echo "export MONGODB_AUTH=$MONGODB_AUTH" >> mongo_conn.sh
echo "export MONGO_DB=$MONGO_DB" >> mongo_conn.sh
echo "export MONGO_URI=$MONGO_URI" >> mongo_conn.sh
echo "check $(pwd)/mongo_conn.sh for mongo connection environment variables";

bash -il launch-mongo.sh
bash -il init-mongo.sh

redis-server &

/etc/init.d/postgresql start \
    && RAILS_ENV=development rails s -b0.0.0.0 -p 8081