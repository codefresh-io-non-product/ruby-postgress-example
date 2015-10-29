#/bin/bash
set -e

echo 'connecting to mongo for initialization of first user'
mongo --nodb --eval "var password=\"$MONGODB_AUTH\", username=\"$CF_USER_NAME\", database=\"$MONGO_DB\"; " /opt/codefresh/mongo/init-mongo.js

exit 0
