FROM jetbrains/teamcity-server
RUN mkdir -p /data/teamcity_server/datadir/lib/jdbc \
  && cd /data/teamcity_server/datadir/lib/jdbc/ \
  && curl -O https://jdbc.postgresql.org/download/postgresql-42.2.1.jar

CMD ["/run-services.sh"]