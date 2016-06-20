#!/bin/sh

set -ex

bundle exec middleman build --clean
rsync -e "ssh -p 222" -avz build/ zadevchat.io@zadevchat.io:/var/www/zadevchat.io/
