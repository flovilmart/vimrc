FROM alpine:edge

RUN apk add neovim curl bash openssh-client git

RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
RUN ln -sf /usr/bin/nvim /usr/bin/vi

WORKDIR /root/src/flovilmart/vimrc

COPY . .

# Adds SSH keys to make sure we can clone submodules
RUN --mount=type=ssh ./install.sh all
RUN sed -i "s#/opt/homebrew/bin/nu#/bin/bash#" ./plugin/after/styling.lua


CMD nu
