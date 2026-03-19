#!/bin/bash
set -e

# Keep trying until the PostGIS database starts accepting connections.
until pg.sh -c 'select 1' >/dev/null 2>&1; do
    sleep 1
done

# Clear and reuse the deferred execution file for schema scripts.
echo '' >/last

/subconf.sh /tmp/mail/conf.sh
/subconf.sh /tmp/web/conf.sh
/subconf.sh /tmp/admin/conf.sh
/subconf.sh /tmp/wms/conf.sh

# Extension images may add extra schemas in /ddl.
[ -x /ddl/conf.sh ] && /subconf.sh /ddl/conf.sh

# shellcheck disable=SC1091
source /last
