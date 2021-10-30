local _M = {}

-- Common Functions
function _M.utils_set(list)
    local set = {}
    for _, l in ipairs(list) do set[string.lower(l)] = true end
    return set
end

-- Get Trust Response Headers
function _M.get_resp_trust_headers()
    local resp_headers = {
        "Accept-Ranges",
        "Age",
        "Allow",
        "Cache-Control",
        "Content-Encoding",
        "Content-Language",
        "Content-Length",
        "Content-Location",
        "Content-MD5",
        "Content-Range",
        "Content-Type",
        "Date",
        "ETag",
        "Expires",
        "Last-Modified",
        "Location",
        "Pragma",
        "refresh",
        "Retry-After",
        "Server",
        "Trailer",
        "Transfer-Encoding",
        "Vary",
        "Via",
        "Warning",
        "Connection",
        "X-Cache"
    }

    return _M.utils_set(resp_headers)
end

-- Get Trust Resquest Headers
function _M.get_req_trust_headers()
    local req_headers = {
        "Accept",
        "Accept-Charset",
        "Accept-Encoding",
        "Accept-Language",
        "Accept-Ranges",
        "Cache-Control",
        "Connection",
        "Content-Length",
        "Content-Type",
        "Date",
        "Expect",
        "From",
        "Host",
        "If-Match",
        "If-Modified-Since",
        "If-None-Match",
        "If-Range",
        "If-Unmodified-Since",
        "Max-Forwards",
        "Pragma",
        "Range",
        "Upgrade",
        "User-Agent",
        "Via",
        "Warning",
        "Authorization"
    }

    return _M.utils_set(req_headers)
end

-- Convert hex to raw
function _M.from_hex(s)
    return (s:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

-- gzip compress and uncompress
local zlib = require "zlib"
function _M.compress(str)
   local level = 5
   local windowSize = 15+16
   -- return zlib.deflate()(str, "finish")
   return zlib.deflate(level, windowSize)(str, "finish")
end

function _M.uncompress(str)
   local level = 5
   local windowSize = 15+16
   return zlib.inflate()(str, "finish")
   -- return zlib.inflate(level, windowSize)(str, "finish")
end

-- AES Object
local aes = require "resty.aes"
function _M.get_aes()
    local key = "#o!7glj?WRA66o6HotH6he2ecr*r=t10z_DReTL7l#2bef4P@_62s#eS7mO+Rox5"
    return aes:new(key)
end

return _M
