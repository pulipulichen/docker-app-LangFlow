#!/bin/bash

# Path to the file to check
LOCK_FILE="/tmp/nextcloud-data-initialized.txt"


# =======================

cp -rf /templates/* /var/www/html/core/templates/
cp -rf /dist/* /var/www/html/dist/


# Check if the file exists
if [ -f "$LOCK_FILE" ]; then
    echo "Initialization file exists: $LOCK_FILE"
    echo "Exiting script."
    exit 0  # for test
fi

# =================================================================

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
/var/www/html/occ app:disable files_sharing
/var/www/html/occ app:disable nextcloud_announcements

# =================================================================

/var/www/html/occ app:enable files_external
/var/www/html/occ files_external:create "data" local null::null -c datadir=/data

# =================================================================

# Define Nextcloud path and URL
EXTERNAL_SITE_URL="http://localhost:$LANGFLOW_PORT/"
SITE_NAME="LANGFLOW"

# Navigate to Nextcloud directory
cd "$NEXTCLOUD_PATH" || exit 1

# Add external site
/var/www/html/occ app:enable external
# /var/www/html/occ config:app:set external sites --value="{1:\"url\":\"$EXTERNAL_SITE_URL\",\"name\":\"$SITE_NAME\"}]"
# /var/www/html/occ config:app:set external sites --value="{\"id\":1,\"name\":\"$SITE_NAME\",\"url\":\"$EXTERNAL_SITE_URL\",\"redirect\":false}"

# Confirm the addition
echo "Added external site '$SITE_NAME' with URL '$EXTERNAL_SITE_URL' to Nextcloud."

# =======================

touch $LOCK_FILE