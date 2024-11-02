all() {
  TMPDIR=$(mktemp -d)
	brew bundle
	ln -sfn $(pwd) ${HOME}/.config/nvim
	nvim -u ~/.config/nvim/init.lua -c PlugInstall -c quitall
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	~/.cargo/bin/rustup install stable
	~/.cargo/bin/rustup component add clippy
	# GO111MODULE=on go get golang.org/x/tools/gopls@latest
	nvim -c PlugStatus -c "write ${TMPDIR}/PlugStatus.out" -c quitall
	cat ${TMPDIR}/PlugStatus.out
}

java() {
  brew install jdtls
}

$1
