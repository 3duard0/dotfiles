echo "Installing tmux and tmuxinator"

apt-get install tmux tmuxinator


cp -i .tmux.conf "$HOME/"
cp -Ri .tmuxinator "$HOME/"
