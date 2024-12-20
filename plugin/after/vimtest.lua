-- " vim-test
-- "
local is_running = function(container_name)
  return os.execute("docker compose ps "..container_name.." 2>&1 | grep "..container_name.." > /dev/null") == 0
end

local docker_run = function(cmd, container_name)
  return 'docker-compose run --rm -e RAILS_ENV=test --entrypoint="'..cmd.. '" '..container_name
end

local docker_exec = function(cmd, container_name)
  return 'docker-compose exec -e RAILS_ENV=test '..container_name..' sh -c "'..cmd..'"'
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
vim.g['test#preserve_screen'] = 1
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
