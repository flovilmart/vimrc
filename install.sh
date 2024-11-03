set +ex

all() {
  setup_shell
  TMPDIR=$(mktemp -d)
  install_brew_deps
  install_apk_deps
	ln -sfn $(pwd) ${HOME}/.config/nvim
  nvim -c PlugInstall -c "write ${TMPDIR}/PlugInstall.out" -c quitall
  cat ${TMPDIR}/PlugInstall.out
  nvim -c PlugStatus -c "write ${TMPDIR}/PlugStatus.out" -c quitall
	cat ${TMPDIR}/PlugStatus.out
  nvim -c TSUpdate -c quitall

  lang_server ruby
  lang_server typescript
}

install_brew_deps() {
	which brew && brew bundle
}

install_apk_deps() {
  which apk && apk add nodejs npm ruby ruby-dev make clang
}

setup_shell() {
  NUSHELL_PATH=$(which nu)
  if [ "${NUSHELL_PATH}" != "/usr/bin/nu" ]; then
    echo "Setting up NuShell to /usr/bin/nu"
    ln -s ${NUSHELL_PATH} /usr/bin/nu
  fi
}

lang_server() {
  java() {
    which brew && brew install jdtls
  }

  rust() {
  	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  	~/.cargo/bin/rustup install stable
  	~/.cargo/bin/rustup component add clippy
  }

  go() {
  	GO111MODULE=on go get golang.org/x/tools/gopls@latest
  }

  typescript() {
    npm install -g typescript typescript-language-server
  }

  ruby() {
    gem install solargraph
  }

  $1
}

invoke=$1
shift

$invoke $@