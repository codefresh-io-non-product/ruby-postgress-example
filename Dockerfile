FROM codefresh/buildpacks:rails-postgres

ADD ./ /usr/app/dir/

ADD start.sh /opt/codefresh/
ADD build.sh /opt/codefresh/
RUN chmod +x /opt/codefresh/*.sh

WORKDIR /usr/app/dir/

RUN \
    bash -il /opt/codefresh/build.sh

# ================================== sh scripts ==================================

EXPOSE 8080
EXPOSE 8081

================================================

CMD bash -il /opt/codefresh/start.sh
