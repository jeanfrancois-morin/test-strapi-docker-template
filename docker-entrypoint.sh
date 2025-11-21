#!/bin/sh
set -e

cd /opt/app

# Run strapi using node directly
exec node node_modules/@strapi/strapi/bin/strapi.js develop
