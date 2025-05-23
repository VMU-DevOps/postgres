FROM postgres:17

# Copy pg_hba.conf
COPY pg_hba.conf /tmp/pg_hba.conf

# Inject custom config after initdb
RUN echo "\ncp /tmp/pg_hba.conf \"$PGDATA\"/pg_hba.conf" >> /usr/local/bin/docker-entrypoint.sh
