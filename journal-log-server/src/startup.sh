#!/bin/bash

/usr/lib/systemd/systemd-journal-remote --listen-http=19532 --output=/journal-log-server/log_store
