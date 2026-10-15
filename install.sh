set -ex

all() {
  setup_shell
  TMPDIR=$(mktemp -d)
  install_brew_deps
  install_apk_deps
  mkdir -p ${HOME}/.config
	ln -sfn $(pwd) ${HOME}/.config/nvim

  install_nvim_deps
  setup_treesitter
}

install_brew_deps() {
  if command -v brew > /dev/null; then
	  brew bundle
  fi
}

install_apk_deps() {
  if command -v apk > /dev/null; then
    # gcc + musl-dev give nvim-treesitter a working `cc` with linker and libc headers;
    # clang alone fails every parser compile with "posix_spawn failed".
    apk add nodejs npm ruby ruby-dev make gcc musl-dev ripgrep openssl
  fi
}

install_nvim_deps() {
  # wait=true blocks until every plugin, including nvim-treesitter's `:TSUpdate`
  # build hook, has finished; otherwise quitall can interrupt the parser builds.
  nvim --headless -c "lua require('lazy').install({ wait = true })" -c "write ${TMPDIR}/PlugInstall.out" -c quitall
  cat ${TMPDIR}/PlugInstall.out
  nvim --headless -c "lua require('lazy').health()" -c "write ${TMPDIR}/PlugStatus.out" -c quitall
	cat ${TMPDIR}/PlugStatus.out
}

setup_treesitter() {
  # Parsers were built by the lazy build hook above; this is a fast no-op when
  # they are up to date and a real build only if something is missing. Fail
  # loudly instead of leaving an image without parsers.
  nvim --headless +TSUpdateSync +quitall
  missing=""
  for lang in ruby typescript javascript go lua vim query vimdoc c rust nu; do
    test -f "${HOME}/.local/share/nvim/lazy/nvim-treesitter/parser/${lang}.so" || missing="${missing} ${lang}"
  done
  if [ -n "${missing}" ]; then
    echo "treesitter parsers missing:${missing}" >&2
    exit 1
  fi
}

setup_shell() {
  if command -v nu > /dev/null; then
    NUSHELL_PATH=$(which nu)
    if [ "${NUSHELL_PATH}" != "/usr/bin/nu" ]; then
      echo "Setting up NuShell to /usr/bin/nu"
      ln -s ${NUSHELL_PATH} /usr/bin/nu || echo "unable to symlink nu to /usr/bin/nu, please do this manually"
    fi
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

if [ "$#" -eq 0 ]; then
    set -- all
fi
invoke=${1}
shift

$invoke $@
