#!/usr/bin/env bash
set -e
cd /usr/app/dir/

rbenv local 2.2.0
gem install bundle
RUBYVERSIONNUMBER="$(bundle platform --ruby | sed 's/ruby//' | sed 's/ //' | sed 's/)//' | sed 's/(//')"
RUBYVERSION="$(rbenv install --list | grep "^  $RUBYVERSIONNUMBER" | tail -1)"

rbenv install $RUBYVERSION --skip-existing
rbenv local $RUBYVERSION

ruby /opt/codefresh/prepare_project.rb
/etc/init.d/postgresql start

gem install bundle
bundle install -j4
rake db:setup db:migrate