#! /bin/bash

echo $GH_TOKEN > /github-backup/gh_token
cron -f
