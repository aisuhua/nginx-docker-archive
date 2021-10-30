local tool = require "tool"
local str = require "resty.string"

local aes_obj = tool.get_aes()

-- Decrypt uri
local arg, err = string.sub(ngx.var.request_uri, 2)
if arg ~= '' then
    local decrypted_uri = aes_obj:decrypt(tool.from_hex(arg))
    ngx.var.r_uri =  string.format("/%s", decrypted_uri)

    -- ngx.log(ngx.STDERR, arg)
    -- ngx.log(ngx.STDERR, ngx.var.r_uri)
end

-- Decrypt Body
local encrypted_body = ngx.req.get_body_data()
if encrypted_body then
    -- ngx.log(ngx.STDERR, encrypted_body)

    -- encrypted_body = uncompress(encrypted_body)
    local decrypted_body = aes_obj:decrypt(encrypted_body)

    -- ngx.log(ngx.STDERR, decrypted_body)
    ngx.req.set_body_data(decrypted_body)
end

