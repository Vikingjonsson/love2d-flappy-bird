LOG = {}
local active = false

---@param is_active boolean
function LOG.set_active(is_active)
  active = is_active
end

---Pritty print values
---@param value string value to print
---@param tag ?string [optional] tag the log message
---@param indent ?number [optional] space to indent log defaults to 2
function LOG.dump(value, tag, indent)
  local function print_divider()
    print('---------------------')
  end

  if not active then
    return
  end

  if not indent then
    indent = 2
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
    if tag then
      print('Tag: ' .. tag)
    end

    print('Type: ' .. type(value))
    print('Value: ' .. value)
    print_divider()
    return
  end
end

return LOG
