#! /bin/sh
# Docker entrypoint script.

# Wait until Postgres is ready
echo "Testing if Postgres is accepting connections. {$PGHOST} {$PGPORT} ${PGUSER}"
while ! pg_isready -q -h $PGHOST -p $PGPORT --username=$PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
exec mix phx.server
