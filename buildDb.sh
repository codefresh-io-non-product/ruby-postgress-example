#!/usr/bin/env bash
set -e
cd /usr/app/dir/

/etc/init.d/postgresql start
ruby /opt/codefresh/prepare_project.rb
bundle install -j4
rake db:setup db:migrate