# Github Sync
This project will create a docker container which will clone all of your github repose into the container and fetch them every day.

# Setup
1. Make a Github Personal Access Token (give it 'repo' and 'org:read' perms)
	1. https://github.com/settings/tokens
1. build the docker container locally 
	1. `docker compose build github-backup-run`
1. start the container 
	1. `GH_TOKEN=<github-PAT> REPO_STORE=<GH_STORAGE_DIR> docker compose up -d github-backup-run`
