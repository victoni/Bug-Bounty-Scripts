-- HEAD --

local shortport = require "shortport"
local stdnse = require "stdnse"
local string = require "string"

description = [[
The script uses ffuf to automatically fuzz any open http(s) services.
]]

author = "Viktor Markopoulos <https://twitter.com/vict0ni>"
license = "0xtavian's swag"
categories = {"discovery", "intrusive", "fuzzing"}

---
-- @usage
-- nmap example.com --script ./0xt-ffuf -script-args "f=-w /path/to/wordlist.txt -of csv -o 0xtavian.csv" -oX nmap_c.xml
--
-- @args f the ffuf arguments
--       (no default)
--
-- @output
-- PORT      STATE SERVICE    REASON
-- 22/tcp    open  ssh        syn-ack
-- 80/tcp    open  http       syn-ack
-- |_0xt-ffuf: Command executed: ffuf -u "http://example.com:80/FUZZ" -w /path/to/wordlist.txt -of csv -o 0xtavian.csv
-- 9929/tcp  open  nping-echo syn-ack
-- 31337/tcp open  Elite      syn-ack

-- RULES --
portrule = shortport.http

local function get_ssl(port)
	local ssl = port.version.service_tunnel == "ssl" or (port.version.sevice_name == nil and port.service:match("https") ~= nil)
	if ssl then
		return "https"
	end
	return "http"
end

-- ACTION --
action = function(host, port)
			
			-- build the ffuf command

			-- http or https
			local protocol = get_ssl(port)

			-- arguments: extention, filename
			local options = stdnse.get_script_args('f') or stdnse.get_script_args(SCRIPT_NAME .. '.f')

			local command = string.format('ffuf -u "' .. protocol .. '://%s:' .. port.number .. '/FUZZ" ' .. options, host.targetname or host.ip)		
		
			local fileName = nil
			local extension = nil
			for token in string.gmatch(options, "[^%s]+") do
				if string.match(token, "csv") then
					extension = "csv"
				elseif string.match(token, "ejson") then
					extension = "ejson"
				elseif string.match(token, "html") then
					extension = "html"
				elseif string.match(token, "md") then
					extension = "md"
				elseif string.match(token, "ecsv") then -- ecsv won't get recognized ????
					extension = "ecsv"
				else
					extension = "json"
				end
   				if string.match(token, ".*%." .. extension) then
   					fileName = string.match(token, ".*%." .. extension)
   					-- print(fileName)
   					break
   				end
			end
			

			-- execute the command
			os.execute(command .. ' >/dev/null 2>&1')

			-- return stdnse.format_output(true, string.format("%s", command)) -- host.targetname or host.ip
			
			-- to print and include in the XML report
			local output_str = "Command executed: " .. command
			local output_tab = stdnse.output_table()
			
			
			local directory = os.getenv("PWD")
			output_tab.output = directory .. "/" .. fileName
			return output_tab, output_str
end
