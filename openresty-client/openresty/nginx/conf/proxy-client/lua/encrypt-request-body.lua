
local tool = require "tool"
local str = require "resty.string"

local aes_obj = tool.get_aes()

-- Encrypt uri
local arg = string.sub(ngx.var.request_uri, 2)

if arg ~= '' then
    local encrypted_uri = aes_obj:encrypt(arg)
    ngx.var.r_uri =  string.format("/%s", str.to_hex(encrypted_uri))

    -- ngx.log(ngx.STDERR, arg)
    -- ngx.log(ngx.STDERR, ngx.var.r_uri)
end

-- Encrypt body
local body = ngx.req.get_body_data()
-- ngx.log(ngx.STDERR, body)

if body then
    local encrypted_body = aes_obj:encrypt(body)
    -- encrypted_body = compress(encrypted_body)
    -- encrypted_body = str.to_hex(encrypted_body)

    -- ngx.log(ngx.STDERR, encrypted_body)
    ngx.req.set_body_data(encrypted_body)
end
