local function build_task(proj)
  return {
    -- cmd is the only required field. It can be a list or a string.
    cmd = { "dotnet", "build", proj },
    -- additional arguments for the cmd (usually only useful if cmd is a string)
    args = {},
    -- the name of the task (defaults to the cmd of the task)
    name = "Greet",
    -- set the working directory for the task
    cwd = "/tmp",
    -- additional environment variables
  }
end

---@type overseer.TemplateFileProvider
return {
  generator = function(search)
    local proj_files = vim.fs.find({ "*.csproj" }, { type = "file" })

    local tasks = {}
    -- Build launch configs
    for _, proj in ipairs(proj_files) do
      table.insert(build_task(proj))
    end

    -- return a list of tasks
    return tasks
  end,
  -- Optional. Same as template.condition
  condition = {
    filetype = { "c" },
  },
  -- Optional. Some task generators may be slow and thus you may want to cache the results.
  -- By providing a cache key (usually a config file or root directory), overseer will automatically
  -- cache results from slow providers and will clear the cache when that file is written.
  cache_key = function(opts)
    return vim.fs.find("*.slnx", { upward = true, type = "file", path = opts.dir })[1]
  end,
}
