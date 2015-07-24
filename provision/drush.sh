#!/usr/bin/env bash

# Drush
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout 7.x
ln -s /usr/local/src/drush/drush /usr/bin/drush
composer -q install

