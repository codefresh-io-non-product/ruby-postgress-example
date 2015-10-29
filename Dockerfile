FROM codefresh/buildpacks:rails-postgres

WORKDIR /usr/app/dir/

#================Gem dependency===========================
COPY ./Gemfile /usr/app/dir/Gemfile

#================build script===========================
RUN \
    rbenv local 2.2.0 \
    && gem install bundle \
    && RUBYVERSIONNUMBER="$(bundle platform --ruby | sed 's/ruby//' | sed 's/ //' | sed 's/)//' | sed 's/(//')" \
    && RUBYVERSION="$(rbenv install --list | grep "^  $RUBYVERSIONNUMBER" | tail -1)" \
    && rbenv install $RUBYVERSION --skip-existing \
    && rbenv local $RUBYVERSION \
    && rbenv global $RUBYVERSION \
    && ruby /opt/codefresh/prepare_project.rb \
    && gem install bundle \
    && bundle install -j4

#================Db dependency===========================
COPY ./db /usr/app/dir/db
COPY ./Rakefile /usr/app/dir/Rakefile
COPY ./config /usr/app/dir/config
COPY ./ /usr/app/dir/

#================build Db script===========================

RUN \
  mkdir /data/db \
  && /etc/init.d/postgresql start \
  && sleep 2 \
  && RUBYVERSIONNUMBER="$(bundle platform --ruby | sed 's/ruby//' | sed 's/ //' | sed 's/)//' | sed 's/(//')" \
  && RUBYVERSION="$(rbenv install --list | grep "^  $RUBYVERSIONNUMBER" | tail -1)" \
  && rbenv install $RUBYVERSION --skip-existing \
  && rbenv local $RUBYVERSION \
  && rbenv global $RUBYVERSION \
  && ruby /opt/codefresh/prepare_db.rb \
  && rake db:setup db:migrate

#================start allow===========================

COPY start.sh /opt/codefresh/
COPY startM.sh /opt/codefresh/
COPY ./mongo/ /opt/codefresh/mongo/
COPY ./mongo/mongodb.conf /etc/mongodb/
ENV CF_USER_EMAIL=default
ENV CF_USER_NAME=default
RUN \
  chmod +x /opt/codefresh/*.sh

#================start and expose project===========================

EXPOSE 8081

CMD bash -il /opt/codefresh/startM.sh