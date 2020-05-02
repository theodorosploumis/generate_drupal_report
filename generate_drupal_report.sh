#!/bin/bash -e
# Requires composer, drush, php
# A script that generates several txt reports files for a Drupal 8.x project
# I use this for Maintenance & Updates Reports.
# See also https://gist.github.com/theodorosploumis/02b4e4df8989cb0072dfbbbdf89922bd

LOCK=composer.lock
if [ ! -f "$LOCK" ];
then
  echo "File composer.lock not found. Run this command on composer project root."
  exit 1
fi

drush_check=$(eval "drush status --field=drupal-version")
drupal_version="${drush_check:0:1}"
if [ "$drupal_version" != "8" ]
then
  echo "Sorry, only Drupal 8.x is supported."
  exit 1
fi

read -e -p "Please enter the Report prefix: " -i "$drush_check" prefix

# Generate php packages list
echo "1. Generating PHP Packages Report.'"
echo "Running 'composer show...'"

composer_show="composer show | awk '{print \$1, \$2}'"
composer_show_results=$(eval "$composer_show")
echo "$composer_show_results" > ${prefix}_php_packages.txt

better_table=$(eval "column -t -s ' ' ${prefix}_php_packages.txt")

echo "PHP Package                                Version" > ${prefix}_php_packages.txt
echo "------------------------------------------------------">> ${prefix}_php_packages.txt
echo "$better_table" >> ${prefix}_php_packages.txt

sed --in-place '/drupal/d' ${prefix}_php_packages.txt


# Generate Drupal modules installed list (no core)
echo "2. Generating Drupal modules installed Report.'"
echo "Running 'drush pm:list...'"

drupal_show='drush pm:list --status=enabled --no-core --format="table" --fields="name,version"'
drupal_show_results=$(eval "$drupal_show")
echo "$drupal_show_results" > ${prefix}_drupal_modules.txt