
local zzlib = require "zzlib.zzlib"
local tool = require "tool"
local str = require "resty.string"

local aes_obj = tool.get_aes()

-- 获取当前响应数据
local chunk, eof = ngx.arg[1], ngx.arg[2]

-- 定义全局变量，收集全部响应
if ngx.ctx.buffered == nil then
    ngx.ctx.buffered = {}
end

-- 如果非最后一次响应，将当前响应赋值
if chunk ~= "" and not ngx.is_subrequest then
    table.insert(ngx.ctx.buffered, chunk)

    -- 将当前响应赋值为空，以修改后的内容作为最终响应
    ngx.arg[1] = nil
end

-- 如果为最后一次响应，对所有响应数据进行处理
if eof then
    -- 获取所有响应数据
    local whole = table.concat(ngx.ctx.buffered)
    ngx.ctx.buffered = nil

    -- 进行你所需要进行的处理
    local aes = require "resty.aes"
    -- ngx.log(ngx.STDERR, whole)
   
    local content_encoding = ngx.resp.get_headers()["Content-Encoding"]
    -- ngx.log(ngx.STDERR, content_encoding)

    if content_encoding == "gzip" then
        whole = zzlib.gunzip(whole)
    end 
    
    local decrypted = aes_obj:decrypt(whole)
    -- ngx.log(ngx.STDERR, decrypted)

    -- ngx.header.content_encoding = nil
    -- 重新赋值响应数据，以修改后的内容作为最终响应
    
    -- local accept_encoding = ngx.req.get_headers()['Accept-Encoding']
    -- ngx.log(ngx.STDERR, accept_encoding)
    
    -- if content_encoding == "gzip" and accept_encoding and accept_encoding:match('gzip') then
    --     ngx.arg[1] = tool.compress(decrypted)
    -- else
    --     ngx.arg[1] = decrypted
    -- end
    
    if content_encoding == "gzip" then
        ngx.arg[1] = tool.compress(decrypted)
    else
        ngx.arg[1] = decrypted
    end
    
    -- ngx.log(ngx.STDERR, ngx.arg[1])
    -- ngx.arg[1] = tool.compress(decrypted)

    ngx.arg[2] = true
end
