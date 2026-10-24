#!/bin/bash
set -e

if [ -n "$PORT" ] && [ "$PORT" != "8080" ]; then
  sed -i "s/port=\"8080\"/port=\"$PORT\"/" "$CATALINA_HOME/conf/server.xml"
fi

exec "$CATALINA_HOME/bin/catalina.sh" run
