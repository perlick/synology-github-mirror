#!/bin/bash

REPO_LIMIT=10000
SYNC_DIR="/github-backup/repo_store"
GH_TOKEN=$(cat /github-backup/gh_token)


function list_repos(){
        gh repo list --json name --jq '.[] | [.name] | @csv' | xargs -I NAME echo NAME
}
export -f list_repos

function clone_repo(){
        gh repo clone $1 -- --bare
}
export -f clone_repo

function sync_all(){
        cd $SYNC_DIR
        for REPO_NAME in $(list_repos); do
                clone_repo $REPO_NAME
                cd $REPO_NAME.git
                git fetch
                cd ../
        done
}
export -f sync_all

function main(){
        echo "GH_TOKEN=$GH_TOKEN"
        mkdir -p ~/.ssh
        ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
	if $(gh auth status); then
                sync_all
                exit 0
        else
                gh auth login -h Github.com --with-token <<< "$GH_TOKEN"
        fi
}
main

