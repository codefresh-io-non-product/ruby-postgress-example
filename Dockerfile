FROM codefresh/buildpacks:rails-postgres

ADD ./ /usr/app/dir/
WORKDIR /usr/app/dir/

RUN \
    rbenv local 2.1.0 \
    && gem install bundle \
    && RUBYVERSION="$(bundle platform --ruby | sed 's/ruby//' | sed 's/ //' | sed 's/)//' | sed 's/(//')" \
    && RUBYVERSION="$(rbenv install --list | grep "^  $RUBYVERSION" | tail -1)" \
    && rbenv install $RUBYVERSION --skip-existing \
    && rbenv local $RUBYVERSION \
    && gem install bundle \
    && bundle install -j4 \
    && rake db:setup db:migrate

# ================================== sh scripts ==================================

ADD start.sh /opt/codefresh/
RUN chmod +x /opt/codefresh/*.sh

EXPOSE 8080
EXPOSE 8081

================================================

CMD bash -il /opt/codefresh/start.sh
