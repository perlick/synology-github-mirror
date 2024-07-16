# Journald Log Server
Very simple package to run systemd-journal-remote in passive mode on port 19532. Journal files are then stored in volume which can be mounted to host system. 

# Viewing logs
## In Synology
You can _maybe_ use the journalctl executable in the dsm to view logs. For me, I got this error. 

```
user@synology:~$ journalctl -D /volume1/journal/remote
Error was encountered while opening journal files: Protocol not supported
-- No entries --
```
I assume some dependency must be outdated in DSM7.

## In Docker Container on Synology
I was able to view logs in the docker container running the server as you would expect
```
sudo docker exec -it <container> /bin/bash
journalctl -D log_store -fa
```

## On Another Machine
If these files are being server over th network somehow, you should be able to mount that location to your local filesystem and view from there. This worked for me on my linux computer.


# Example Client Config
install systemd-journal-remote
```
sudo apt-get update && \
    sudo apt-get install systemd-journal-remote -y
```

Setup upload location in `/etc/systemd/journal-upload.conf`

```
[Upload]
URL=http://<ip>:19532
```
enable service
```
sudo systemctl enable --now systemd-journal-upload.service
```
change systemd unit so it starts after tailscale and always restarts on failure. 
```
sudo vim /etc/systemd/system/multi-user.target.wants/systemd-journal-upload.service

[Unit]
After=tailscaled.service
StartLimitIntervalSec=0
StartLimitBurst=0

[Service]
Restart=always
RestartSec=5m
```

restart systemd
```
sudo systemctl daemon-reload
sudo systemctl restart systemd-journal-upload
```

# Tailscale integration
For my use case I have all my nodes running tailscale. This allows me to take them out of network and still have logs reporting back to home base. 

If you're going this route make sure to do this step on the Synology NAS otherwise log files won't be seperated correctly by source ip
https://tailscale.com/kb/1131/synology#enabling-synology-outbound-connections
