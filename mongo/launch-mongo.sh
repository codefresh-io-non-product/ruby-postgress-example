echo "mongo storage at /data/mongodb"
mkdir -p /data/mongodb

echo 'MongoDB config at /etc/mongodb/mongodb.conf:'
cat /etc/mongodb/mongodb.conf

echo 'starting mongo daemon with config at /etc/mongodb/mongodb.conf'
/usr/bin/mongod --config /etc/mongodb/mongodb.conf &
