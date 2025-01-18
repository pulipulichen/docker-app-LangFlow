#!/bin/bash

/var/www/html/occ app:disable activity
/var/www/html/occ app:disable app_api
/var/www/html/occ app:disable bruteforcesettings
/var/www/html/occ app:disable systemtags
/var/www/html/occ app:disable comments
/var/www/html/occ app:disable contactsinteraction
/var/www/html/occ app:disable dashboard
/var/www/html/occ app:disable files_trashbin
/var/www/html/occ app:disable files_external
/var/www/html/occ app:disable files_reminders
/var/www/html/occ app:disable federation
/var/www/html/occ app:disable files_downloadlimit
/var/www/html/occ app:disable firstrunwizard
/var/www/html/occ app:disable logreader
/var/www/html/occ app:disable serverinfo
/var/www/html/occ app:disable webhook_listeners
/var/www/html/occ app:disable notifications
/var/www/html/occ app:disable password_policy
/var/www/html/occ app:disable photos
/var/www/html/occ app:disable privacy
/var/www/html/occ app:disable recommendations
/var/www/html/occ app:disable related_resources
/var/www/html/occ app:disable sharebymail
/var/www/html/occ app:disable support
/var/www/html/occ app:disable circles
/var/www/html/occ app:disable updatenotification
/var/www/html/occ app:disable survey_client
/var/www/html/occ app:disable user_status
/var/www/html/occ app:disable files_versions
/var/www/html/occ app:disable weather_status

/var/www/html/occ app:enable files_external
/var/www/html/occ files_external:create "data" local null::null -c datadir=/data