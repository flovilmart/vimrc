-- " vim-test
-- "
-- function! TransformExecRubyApp(cmd) abort
--   return 'docker-compose exec -e RAILS_ENV=test app sh -c '.shellescape(a:cmd)
-- endfunction
-- function! TransformRubyApp(cmd) abort
--   return 'docker-compose run --rm -e RAILS_ENV=test --entrypoint='.shellescape(a:cmd). ' app'
-- endfunction
-- function! DockerComposeRun(cmd) abort
--   return 'docker-compose run --rm -e RAILS_ENV=test --entrypoint='.shellescape(a:cmd). ' app'
-- endfunction
-- function! DockerComposeExec(cmd, app) abort
--   return 'docker-compose exec -e RAILS_ENV=test '.a:app.' sh -c '.shellescape(a:cmd)
-- endfunction
-- 
-- function! TransformDockerCompose(cmd) abort
--   if empty(glob("docker-compose.yml"))
--     return a:cmd
--   endif
--   if getcwd() =~ "app-messaging-service"
--     return DockerComposeExec(a:cmd, "app-messaging-service")
--   endif
--   if getcwd() =~ "connected_home_service"
--     return DockerComposeExec(a:cmd, "app")
--   endif
--   if getcwd() =~ "hodor"
--     " return DockerComposeRun(a:cmd)
--     return DockerComposeExec(a:cmd, "hodor")
--   endif
--   if getcwd() =~ "flatbook"
--     return DockerComposeExec(a:cmd, "flatbook")
--   endif
--   return TransformRubyApp(a:cmd)
-- endfunction
-- 
-- let g:test#custom_transformations = {'do': function('TransformDockerCompose')}
-- let g:test#transformation = 'do'
-- let test#strategy = "vimux"
-- let test#preserve_screen = 0
-- let test#echo_command = 0
-- let g:test#javascript#runner = 'jest'
-- let test#javascript#patterns = {
--   \ 'test': ['\v^\s*%(it|test)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
--   \ 'namespace': ['\v^\s*%(describe|suite|context)\s*[( ]\s*%("|''|`)(.*)%("|''|`)'],
-- \}
-- nmap <silent> t<C-n> :TestNearest<CR>
-- nmap <silent> t<C-f> :TestFile<CR>
-- nmap <silent> t<C-s> :TestSuite<CR>
-- nmap <silent> t<C-l> :TestLast<CR>
-- nmap <silent> t<C-g> :TestVisit<CR.>
--
local is_running = function(container_name)
  return os.execute("docker compose ps "..container_name.." 2>&1 | grep "..container_name.." > /dev/null") == 0
end

local docker_run = function(cmd, container_name)
  return 'docker-compose run --rm -e RAILS_ENV=test --entrypoint='..vim.fn.shellescape(cmd).. ' '..container_name
end

local docker_exec = function(cmd, container_name)
  return 'docker-compose exec -e RAILS_ENV=test '..container_name..' sh -c '..vim.fn.shellescape(cmd)
end

local has_docker_compose = function()
  return os.execute("docker compose ps 2>&1 > /dev/null") == 0
end

local get_container_name = function() 
  local dirname = string.match(vim.fn.getcwd(), "([A-Za-z_\\-]+)$")
  local names = { "app-messaging-service" , ["connected_home_service"] = "app", "hodor", "flatbook" }
  
  for a, name in pairs(names) do
    if name == dirname then
      container_name = name
    elseif a == dirname then
      container_name = name
    end
  end

  return container_name
end

local transformDockerCompose = function(cmd) 
  if io.open("docker-compose.yml", "r") == nil then
    return cmd
  end

  conatiner_name = get_container_name()

  if container_name == nil then
    -- Container not defined 
    return cmd
  end
  -- check if container is running
  if not is_running(container_name) then
    -- Container not running
    return docker_run(cmd, container_name)
  end 

  -- Container is runing 
  return docker_exec(cmd, container_name)
end

vim.g["test#custom_transformations"] = {['do'] = transformDockerCompose}
vim.g['test#transformation'] = "do"
vim.g['test#strategy'] = "vimux"
vim.g['test#preserve_screen'] = 0
vim.g['test#echo_command'] = 0
vim.g['test#javascript#runner'] = 'jest'
vim.g['test#javascript#patterns'] = {
  ['test'] = {'\\v^\\s*%(it|test)\\s*[( ]\\s*%("|\'\'|`)(.*)%("|\'\'|`)'},
  ['namespace'] = {'\\v^\\s*%(describe|suite|context)\\s*[( ]\\s*%("|\'\'|`)(.*)%("|\'\'|`)'},
} 

local noremap = function(rhs, lhs, desc)
  vim.keymap.set("n", rhs, lhs, {noremap = true, silent=true}, desc)
end

noremap("t<C-n>", ":TestNearest<CR>", "Run nearest test") 
noremap("t<C-f>", ":TestFile<CR>", "Run test file") 
noremap("t<C-s>", ":TestSuite<CR>", "Run test suite") 
noremap("t<C-l>", ":TestLast<CR>", "Run Last") 
noremap("t<C-g>", ":TestVisit<CR>", "Run Test Visit") 
