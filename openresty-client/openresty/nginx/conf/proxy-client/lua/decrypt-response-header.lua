
local tool = require "tool"
local str = require "resty.string"

local resp_trust_headers = tool.get_resp_trust_headers()
local aes_obj = tool.get_aes()
local headers = ngx.resp.get_headers()

for k, v in pairs(headers) do
    -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
    if not resp_trust_headers[k] then
        -- ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
        
        ngx.header[k] = nil  
        k = aes_obj:decrypt(tool.from_hex(k))
        v = aes_obj:decrypt(tool.from_hex(v))
        
        if k == 'set-cookie' then 
            local json = require "json"
            v = json.decode(v)
        end
        
        -- ngx.log(ngx.ERR, k)
        -- ngx.log(ngx.ERR, v)
 
        ngx.header[k] = v
    end
end

-- Reset Content-Length
ngx.header.content_length = nil
