
local str = require "resty.string"
local tool = require "tool"

local req_trust_headers = tool.get_req_trust_headers()
local aes_obj = tool.get_aes() 

local headers = ngx.req.get_headers()
for k, v in pairs(headers) do
    if not req_trust_headers[k] then
        -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
        
        ngx.req.set_header(k, nil)
        k = str.to_hex(aes_obj:encrypt(k))
        v = str.to_hex(aes_obj:encrypt(tostring(v)))
       
        ngx.req.set_header(k, v)
    end
  -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
end
