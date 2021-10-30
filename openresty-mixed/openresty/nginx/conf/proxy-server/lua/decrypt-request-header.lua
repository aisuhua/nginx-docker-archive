
local str = require "resty.string"
local tool = require "tool"

local req_trust_headers = tool.get_req_trust_headers()
local aes_obj = tool.get_aes() 
local headers = ngx.req.get_headers()

for k, v in pairs(headers) do
    -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
    
    if not req_trust_headers[k] then
        -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
        
        ngx.req.set_header(k, nil)
        local k = aes_obj:decrypt(tool.from_hex(k))
        local v = aes_obj:decrypt(tool.from_hex(v))
        
        -- ngx.log(ngx.ERR, k)
        -- ngx.log(ngx.ERR, v)
 
        ngx.req.set_header(k, v)
    end
end
