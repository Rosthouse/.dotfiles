-- paths to check for project.godot file
local paths_to_check = { '/', '/../' }
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
  vim.fn.serverstart(godot_project_path .. '/server.pipe')
end

local filter_hide = function(fs_entry)
  return not vim.endswith(fs_entry.name, "uid")
end

-- require("oil").setup({
--     view_options = {
--         show_hidden = true,
--         is_always_hidden = function(name, bufnr)
--             -- for godot projects ignore *.uid files
--             if is_godot_project then
--                 -- ignore *.uid files introduced in godot 4.4
--                 if vim.endswith(name, '.uid') then
--                     return true
--                 end
--                 -- ignore server.pipe file
--                 if name == 'server.pipe' then
--                     return true
--                 end
--             else
--                 return false
--             end
--         end,
--     },
-- })
