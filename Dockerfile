FROM codefresh/buildpacks:rails-postgres

WORKDIR /usr/app/dir/

COPY ./Gemfile /usr/app/dir/Gemfile
COPY ./build.sh /opt/codefresh/build.sh
RUN \
    ruby /opt/codefresh/prepare_project.rb \
    && bash -il /opt/codefresh/build.sh

COPY ./db /usr/app/dir/db
COPY ./Rakefile /usr/app/dir/Rakefile
COPY ./config /usr/app/dir/config
COPY ./prepare_project.rb /opt/codefresh/prepare_db.rb
COPY ./buildDb.sh /opt/codefresh/buildDb.sh
RUN \
    bash -il /opt/codefresh/buildDb.sh

COPY ./ /usr/app/dir/

COPY start.sh /opt/codefresh/
RUN chmod +x /opt/codefresh/*.sh

EXPOSE 3000

CMD bash -il /opt/codefresh/start.sh