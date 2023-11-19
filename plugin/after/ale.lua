
-- nmap <silent> <leader>a <Plug>(ale_next_wrap)
vim.g.ale_linters = {
  ['javascript'] = {'eslint', 'prettier'},
  ['typescript'] = {'eslint', 'prettier'},
  ['typescriptreact'] = {'eslint', 'prettier'},
  ['python'] = {'flake8'},
  ['ruby'] = {}, -- no need for rubocop so we dont report issues twice {'rubocop'},
  ['go'] = {'gopls'},
}

vim.g.ale_fixers = {
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
  ['javascript'] = {'prettier', 'eslint'},
  ['typescript'] = {'prettier', 'eslint'},
  ['typescriptreact'] = {'prettier', 'eslint'},
  ['go'] = {'gofmt'},
  ['rust'] = {'rustfmt'},
  ['ruby'] = {'rubocop'},
}

-- " Disabling highlighting
vim.g.ale_set_highlights = 0
vim.g.ale_sign_column_always = 1
vim.g.ale_open_list = 0
vim.g.ale_disable_lsp = 'auto'

-- " Only run linting when saving the file
vim.g.ale_lint_on_text_changed = 'never'
vim.g.ale_lint_on_enter = 0
vim.g.ale_lint_on_save = 0
vim.g.ale_linters_explicit = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_javascript_eslint_use_global = 1
vim.g.ale_javascript_tsserver_use_global = 1
