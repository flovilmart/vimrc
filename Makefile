
all:
	ln -sfn $(CURDIR) $(HOME)/.config/nvim
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	rustup install stable
	rustup component add clippy
