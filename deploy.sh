#!/bin/sh

set -ex

# Stash changes
git stash -u

bundle exec middleman build --clean
rsync -e "ssh -p 222" -avz build/ zadevchat.io@zadevchat.io:/var/www/zadevchat.io/

# Get the changes back
git stash pop
