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
-- nmap example.com --script ./0xt-ffuf -script-args 'w=/home/op/lists/wordlist.txt,e=csv' -oX nmap_c.xml
--
-- @args w the wordlist to use
--       (no default)
-- @args e th extension to save the output
--       (no default)
--
-- @output
-- PORT      STATE SERVICE    REASON
-- 22/tcp    open  ssh        syn-ack
-- 80/tcp    open  http       syn-ack
-- |_0xt-ffuf: Command executed: ffuf -u "http://example.com:80/FUZZ" -w /home/op/lists/wordlist.txt -of csv -o example.com_80.csv
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
			
			--== build the ffuf command ==--

			-- http or https
			local protocol = get_ssl(port)

			-- arguments: extention, filename
			local ext = stdnse.get_script_args('e') or stdnse.get_script_args(SCRIPT_NAME .. '.e')
			local fileName = (host.targetname or host.ip) .. "_" .. port.number .. '.' .. ext
			local command = string.format('ffuf -u "' .. protocol .. '://%s:' .. port.number .. '/FUZZ" -w /home/op/lists/vic-manual.txt -of ' .. ext .. ' -o ' .. fileName, host.targetname or host.ip)		
			
			-- if wordlist is set
			local wordlist = stdnse.get_script_args('w') or stdnse.get_script_args(SCRIPT_NAME .. '.w')
			if (wordlist) then
				command = string.format('ffuf -u "' .. protocol .. '://%s:' .. port.number .. '/FUZZ" -w ' .. wordlist .. ' -of ' .. ext .. ' -o ' .. fileName, host.targetname or host.ip)
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
