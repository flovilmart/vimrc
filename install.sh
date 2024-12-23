set -ex

all() {
  setup_shell
  TMPDIR=$(mktemp -d)
  install_brew_deps
  install_apk_deps
  mkdir -p ${HOME}/.config
	ln -sfn $(pwd) ${HOME}/.config/nvim
  fix_shell_path

  install_nvim_deps
  setup_treesitter

  lang_server ruby
  lang_server typescript
}

install_brew_deps() {
  if command -v brew > /dev/null; then
	  brew bundle
  fi
}

install_apk_deps() {
  if command -v apk > /dev/null; then
    apk add nodejs npm ruby ruby-dev make clang ripgrep
  fi
}

install_nvim_deps() {
  nvim -c "lua require('lazy').install()" -c "write ${TMPDIR}/PlugInstall.out" -c quitall
  cat ${TMPDIR}/PlugInstall.out
  nvim -c "lua require('lazy').health()" -c "write ${TMPDIR}/PlugStatus.out" -c quitall
	cat ${TMPDIR}/PlugStatus.out
}

setup_treesitter() {
  nvim +TSUpdateSync +quitall
}

setup_shell() {
  if command -v nu > /dev/null; then
    NUSHELL_PATH=$(which nu)
    if [ "${NUSHELL_PATH}" != "/usr/bin/nu" ]; then
      echo "Setting up NuShell to /usr/bin/nu"
      ln -s ${NUSHELL_PATH} /usr/bin/nu
    fi
  fi
}

fix_shell_path() {
  SHELL_PATH=""
  if command -v nu > /dev/null; then
    SHELL_PATH=$(which nu)
  fi

  if [ -z "${SHELL_PATH}" ]; then
    SHELL_PATH="/bin/bash"
    echo "Nu not found in path. Using /bin/bash as default"
  fi
  if [ "${SHELL_PATH}" == "/opt/homebrew/bin/nu" ]; then
    echo "nothing to do..."
  else
    sed -i "s#/opt/homebrew/bin/nu#${SHELL_PATH}#" ./plugin/after/styling.lua
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

  bash() {
    npm install -g bash-language-server
  }

  ruby() {
    gem install -N solargraph
  }

  $1
}

invoke=$1
shift

$invoke $@
