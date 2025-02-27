Nmap script:

```
local nmap = require "nmap"
local http = require "http"
local stdnse = require "stdnse"

description = [[
Bug bounty script to find exposed admin panels, sensitive files, and misconfigured services.
]]

author = "YourName"
license = "Same as Nmap"
categories = {"discovery", "vuln"}

-- Common HTTP(S) ports used by web applications
portrule = function(host, port)
    local http_ports = {80, 81, 443, 3000, 3001, 5000, 5001, 7001, 8000, 8080, 8081, 8443, 8888, 9000, 9200, 10000}
    for _, p in ipairs(http_ports) do
        if port.number == p then
            return true
        end
    end
    return false
end

action = function(host, port)
    local paths = {
        "/admin", "/administrator", "/login", "/wp-admin", "/wp-login.php",
        "/config.php", "/.git/", "/.env", "/robots.txt", "/backup", "/db",
        "/phpinfo.php", "/server-status", "/console", "/dashboard", "/debug",
        "/test", "/staging", "/uploads", "/.DS_Store", "/.htaccess", "/.htpasswd",
        "/cgi-bin/", "/cgi-bin/test.cgi", "/shell", "/setup.php", "/install.php",
        "/api", "/api/v1", "/graphql", "/actuator", "/actuator/health",
        "/adminer.php", "/vendor/phpunit/phpunit/src/Util/PHP/eval-stdin.php"
    }
    
    local results = {}

    for _, path in ipairs(paths) do
        local url = string.format("http://%s:%d%s", host.targetname or host.ip, port.number, path)
        local response = http.get(host, port, path)

        if response and (response.status == 200 or response.status == 403) then
            table.insert(results, string.format("[+] Found: %s (Status: %d)", url, response.status))
        end
    end

    if #results > 0 then
        return stdnse.format_output(true, results)
    else
        return "[-] No sensitive paths found."
    end
end
```


