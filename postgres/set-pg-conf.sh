#!/bin/bash

# Set recommended for TeamCity settings
# https://confluence.jetbrains.com/pages/viewpage.action?pageId=74847395#HowTo...-ConfigureNewlyInstalledPostgreSQLServer
PG_CONF=/var/lib/postgresql/data/postgresql.conf

# The default value of shared_buffers parameter is too small and should be increased:
grep -q -F 'shared_buffers=512MB' $PG_CONF || echo 'shared_buffers=512MB' >> $PG_CONF

# For write-intensive applications such as TeamCity,
# it is recommended to change some of the checkpoint-related parameters:
#
#For PostgreSQL 9.5 and later:
grep -q -F 'max_wal_size = 1500MB' $PG_CONF || echo 'max_wal_size = 1500MB' >> $PG_CONF
grep -q -F 'checkpoint_completion_target=0.9' $PG_CONF || echo 'checkpoint_completion_target=0.9' >> $PG_CONF

# If TeamCity is the only application using the PostgreSQL database,
# we recommend disabling the synchronous_commit parameter:
grep -q -F 'synchronous_commit=off' $PG_CONF || echo 'synchronous_commit=off' >> $PG_CONF