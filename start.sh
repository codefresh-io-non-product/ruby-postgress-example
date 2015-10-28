#!/usr/bin/env bash

redis-server &

/etc/init.d/postgresql start

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL -l

RAILS_ENV=development rails s -p 8081
