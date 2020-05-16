#!/bin/bash
set -x
echo "Configure psql ..."
apk add postgresql-client curl
echo "Psql configured"
echo "Waiting wiki.js server to launch on $WIKI_JS_PORT..."
while ! nc -z $WIKI_JS_HOST $WIKI_JS_PORT; do   
  sleep 1
done
echo "Wiki.js launched"
echo "Fixing wizard ..."
curl -X POST \
  http://$WIKI_JS_HOST:$WIKI_JS_PORT/finalize -H 'Accept: */*' -H 'Content-Type: application/json' -d '{"adminEmail":"'$WIKI_JS_ADMIN_EMAIL'","adminPassword":"'$WIKI_JS_ADMIN_PASSWORD'","adminPasswordConfirm":"'$WIKI_JS_ADMIN_PASSWORD'","siteUrl":"'$WIKI_JS_SITE_URL'","telemetry":"'$WIKI_JS_TELEMETRY'"}'

if [ $? -eq 0 ]; then
    echo "Fixing wizard ok"
else
    echo "Fixing wizard failed"
fi
echo "Waiting postgresql to launch 5432 ..."
while ! nc -z $POSTGRES_HOST 5432; do   
  sleep 1
done
echo "Postgresql launched"
echo "Fixing postgres ..."
export PGPASSWORD=$POSTGRES_PASSWORD
psql --host $POSTGRES_HOST -U $POSTGRES_USER -p $POSTGRES_PORT -d $POSTGRES_DATABASE -c "delete from authentication where key='keycloak';"
psql --host $POSTGRES_HOST -U $POSTGRES_USER -p $POSTGRES_PORT -d $POSTGRES_DATABASE -c "insert into authentication(\"key\",\"isEnabled\",\"config\",\"selfRegistration\",\"domainWhitelist\",\"autoEnrollGroups\")
values ('keycloak','t','{\"authorizationURL\":\"$WIKI_JS_KEYCLOAK_PROTOCOL://$WIKI_JS_KEYCLOAK_HOST/auth/realms/master/protocol/openid-connect/auth\",\"clientId\":\"wiki-js\",\"clientSecret\":\"wiki-js\",\"host\":\"$INGRESS_IP\",\"realm\":\"master\",\"tokenURL\":\"$WIKI_JS_KEYCLOAK_PROTOCOL://$WIKI_JS_KEYCLOAK_HOST/auth/realms/master/protocol/openid-connect/token\",\"userInfoURL\":\"$WIKI_JS_KEYCLOAK_PROTOCOL://$WIKI_JS_KEYCLOAK_HOST/auth/realms/master/protocol/openid-connect/auth\"}','t','{\"v\":[]}','{\"v\":[2]}');"
exit 0
