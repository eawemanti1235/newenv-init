--coded getcustomasset and watermark, ik you find it from autoexecute, idc if you change it too 🤯👍
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "MantiWPF",
    Icon = "rbxassetid://18956441273",
    Text = "MantiWPF v3",
    Duration = 7    
})
print("MantiWPF is injected!")
getgenv().getcustomasset = function(path)
    assert(path ~= "", `arg #1 cannot be empty`)
    assert(type(path) == "string", `arg #1 must be type string`)

    local backslashed_path = string.gsub(path, "/", "\\")
    local success, asset_url = getcustomassetTools(backslashed_path)

    if not success then
        return error(`Failed to get asset URL of '{path}'`, 2)
    end
    return asset_url
end
