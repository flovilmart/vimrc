let g:ale_linters = {
\  'java': ['google_java_format']
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'java': ['google_java_format']
\}

let g:ale_java_google_java_format_executable = '/usr/local/Cellar/google-java-format/1.17.0/bin/google-java-format'
