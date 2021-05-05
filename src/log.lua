LOG = {}
local active = true

---@param is_active boolean
function LOG.set_active(is_active)
  active = is_active
end

---Pritty print values
---@param value string value to print
---@param indent ?number space to indent log
function LOG.dump(value, indent)
  local function print_divider()
    print('---------------------')
  end

  if not active then
    return
  end

  if not indent then
    indent = 0
  end

  if value == nil then
    print('Value is nil')
    print_divider()
    return
  end

  if type(value) == 'table' then
    for k, v in pairs(value) do
      local formatting = string.rep('  ', indent) .. k .. ': '
      if type(v) == 'table' then
        print(formatting)
        LOG.dump(v, indent + 1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))
      else
        print(formatting .. v)
      end
    end
    print_divider()
    return
  end

  if type(value) ~= 'table' then
    print('Type: ' .. type(value))
    print('Value: ' .. value)
    print_divider()
    return
  end
end

return LOG
