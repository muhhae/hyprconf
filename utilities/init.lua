---Debug print
---@param msg string
function debug_print(msg)
	hl.notification.create({ text = "DEBUG: " .. msg, timeout = 3000 })
end

---trim string
---@param s string
---@return string
function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

--- Focus or Launch an App
--- @param initial_class string
--- @param executable string
--- @return function
function focus_or_launch(initial_class, executable)
    return function()
        local windows = hl.get_windows()
        for _, w in ipairs(windows) do
            if w.initial_class == initial_class then
                hl.dispatch(hl.dsp.focus({ window = w }))
                return
            end
        end
        hl.exec_cmd("runapp " .. executable)
    end
end

---Run command asynchronously and run callback
---@param cmd string
---@param callback function|nil
function exec_cmd_with_callback(cmd, callback)
    if callback == nil then
        hl.exec_cmd(cmd)
        return
    end

    local id = tostring(math.random(1, 999999))
    local shm_path = "/dev/shm/hypr_async_" .. id
    local finished_path = shm_path .. "__DONE__"
    local wrapped_cmd =
        string.format("%s > %s; touch %s", cmd, shm_path, finished_path)

    hl.exec_cmd(wrapped_cmd)

    local poller
    poller = hl.timer(function()
        local flag = io.open(finished_path, "r")
        if flag == nil then
            return
        end

        flag:close()
        os.remove(finished_path)
        poller:set_enabled(false)

        local f = io.open(shm_path, "r")
        if f then
            local content = f:read("*a")
            f:close()
            os.remove(shm_path)
            callback(content)
        end
    end, { timeout = 100, type = "repeat" })
    poller:set_enabled(true)
end

---Return keys of table
---@param t table
---@return table
function get_keys(t)
    local keys = {}
    for k, _ in pairs(t) do
        table.insert(keys, k)
    end
    return keys
end

function deep_merge(defaults, override)
    local result = {}
    for _, t in ipairs({ defaults, override }) do
        for k, v in pairs(t) do
            if
                type(v) == "table"
                and (type(result[k]) == "table" or result[k] == nil)
            then
                result[k] = deep_merge(result[k] or {}, v)
            elseif v ~= nil then
                result[k] = v
            end
        end
    end
    return result
end

function copy(t)
    return deep_merge({}, t)
end
