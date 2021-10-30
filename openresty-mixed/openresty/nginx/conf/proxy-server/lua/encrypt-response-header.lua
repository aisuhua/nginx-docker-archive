local tool = require "tool"
local str = require "resty.string"

local resp_trust_headers = tool.get_resp_trust_headers()
local aes_obj = tool.get_aes()
local headers = ngx.resp.get_headers()

for k, v in pairs(headers) do
    if not resp_trust_headers[k] then
        -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
         
        if k == 'set-cookie' then     
            local json = require "json"
            v = json.encode(v)
        end
            
        ngx.header[k] = nil
        k = str.to_hex(aes_obj:encrypt(k))
        v = str.to_hex(aes_obj:encrypt(tostring(v)))
        
        -- ngx.log(ngx.ERR, k)
        -- ngx.log(ngx.ERR, v)
        
        ngx.header[k] = v
    end
  -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
end

-- Reset Content-Length
ngx.header.content_length = nil
