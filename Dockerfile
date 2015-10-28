FROM codefresh/buildpacks:rails-postgres

WORKDIR /usr/app/dir/

COPY ./Gemfile /usr/app/dir/Gemfile
COPY ./build.sh /opt/codefresh/build.sh
RUN \
    bash -il /opt/codefresh/build.sh

COPY ./db /usr/app/dir/db
COPY ./Rakefile /usr/app/dir/Rakefile
COPY ./config /usr/app/dir/config
COPY ./buildDb.sh /opt/codefresh/buildDb.sh
RUN \
    bash -il /opt/codefresh/buildDb.sh

COPY ./ /usr/app/dir/

COPY start.sh /opt/codefresh/
RUN chmod +x /opt/codefresh/*.sh

EXPOSE 8081

#CMD ["bash -il /user/app/dir"]
CMD bash -il /opt/codefresh/start.sh