FROM codefresh/buildpacks:rails-postgres

WORKDIR /usr/app/dir/

#================Gem dependency===========================
COPY ./Gemfile /usr/app/dir/Gemfile

#================build script===========================
COPY ./build.sh /opt/codefresh/build.sh
RUN \
    bash -il /opt/codefresh/build.sh

#================Db dependency===========================
COPY ./db /usr/app/dir/db
COPY ./Rakefile /usr/app/dir/Rakefile
COPY ./config /usr/app/dir/config

#================build Db script===========================
COPY ./buildDb.sh /opt/codefresh/buildDb.sh
RUN \
    bash -il /opt/codefresh/buildDb.sh

#================start project===========================
COPY ./ /usr/app/dir/

COPY start.sh /opt/codefresh/
RUN chmod +x /opt/codefresh/*.sh

EXPOSE 3000

CMD bash -il /opt/codefresh/start.sh