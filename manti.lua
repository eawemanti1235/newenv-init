--coded getcustomasset and watermark, ik you find it from autoexecute, idc if you change it too 🤯👍
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "MantiWPF",
    Icon = "rbxassetid://18956441273",
    Text = "MantiWPF v3",
    Duration = 7    
})
print("MantiWPF is injected!")

assert = function(a, b)
 if not a then  end
end

local passes, fails, undefined = 0, 0, 0
local running = 0

local function getGlobal(path)
	local value = getgenv and getgenv() or getfenv(2)

	while value ~= nil and path ~= "" do
		local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
		value = value[name]
		path = nextValue
	end

	return value
end

local function test(name, aliases, callback, target)
	running = running + 1

	task.spawn(function()
		if not callback then
		elseif not getGlobal(name) then
			fails = fails + 1
		else
			local success, message = pcall(callback)
	        name = tostring(name)
			message = tostring(message)
			if success then
				passes = passes + 1
			else
				fails = fails + 1
			end
		end
	
		local undefinedAliases = {}
	
		for _, alias in ipairs(aliases) do
			if getGlobal(alias) == nil then
				table.insert(undefinedAliases, alias)
			end
		end
	
		if #undefinedAliases > 0 then
			undefined = undefined + 1
		end

		running = running - 1
	end)
end

-- Header and summary

task.defer(function()
	repeat task.wait() until running == 0

	local rate = math.round(passes / (passes + fails) * 100)
	local outOf = passes .. " out of " .. (passes + fails)
end)


test("getcustomasset", {}, function() --
	writefile(".tests/getcustomasset.txt", "success")
	local contentId = getcustomasset(".tests/getcustomasset.txt")
	assert(type(contentId) == "string", "Did not return a string")
	assert(#contentId > 0, "Returned an empty string")
	assert(string.match(contentId, "rbxasset://") == "rbxasset://", "Did not return an rbxasset url")
end)
