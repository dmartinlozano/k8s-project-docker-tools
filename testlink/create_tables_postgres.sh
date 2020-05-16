#!/bin/bash

if [[ $DATABASE_HOST == *":"* ]]; then
    HOST=$(echo $DATABASE_HOST|cut -d ":" -f1)
else
    HOST=$1
fi

export PGPASSWORD=$DATABASE_PASS

psql -h $HOST -U $DATABASE_USER -d $DATABASE_NAME -f /var/www/html/testlink/install/sql/postgres/testlink_create_tables.sql
psql -h $HOST -U $DATABASE_USER -d $DATABASE_NAME -f /var/www/html/testlink/install/sql/postgres/testlink_create_udf0.sql
psql -h $HOST -U $DATABASE_USER -d $DATABASE_NAME -f /var/www/html/testlink/install/sql/postgres/testlink_create_default_data.sql
