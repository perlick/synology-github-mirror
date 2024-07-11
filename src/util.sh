REPO_LIMIT=10000
SYNC_DIR=.

function list_repos(){
	gh repo list -L $REPO_LIMIT --json name --jq '.[] | [.name] | @csv'
}
export -f list_repos

function clone_repo(){
	gh repo clone $1 -- --bare
}
export -f clone_repo

function sync_all(){
	cd $SYNC_DIR
	list_repos | xargs -I REPO_NAME bash -c 'clone_repo REPO_NAME || cd REPO_NAME && git fetch'
}
export -f sync_all

function main(){
	if $(gh auth status); then
		sync_all
		exit 0
	else
		echo "gh cli not logged in!"
		exit 1
	fi
}
