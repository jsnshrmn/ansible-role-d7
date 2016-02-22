#!/usr/bin/env bash
## Create Apache config for Drupal site
PATH=/opt/d7/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

## Require arguments
if [ ! -z "$1" ]
then
  SITEPATH=$1
  echo "Processing $SITEPATH"
else
  echo "Requires site path (eg. /srv/sample) as argument"
  exit 1;
fi

## Site should already be there
if [[ ! -e $SITEPATH ]]; then
    echo "$SITEPATH doesn't exist!"
    exit 1
fi

## Grab the basename of the site to use in conf.
SITE=`basename $SITEPATH`

## Make the apache config
echo "Generating Apache Config."
sudo sh -c "sed "s/__SITE_DIR__/$SITE/g" /etc/httpd/conf.d/d7_init_httpd_template > /etc/httpd/conf.d/srv_$SITE.conf" || exit 1;
sudo sh -c "sed -i "s/__SITE_NAME__/$SITE/g" /etc/httpd/conf.d/srv_$SITE.conf" || exit 1;
sudo systemctl restart httpd || exit 1;