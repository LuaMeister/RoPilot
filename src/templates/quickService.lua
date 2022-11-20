
local ScriptEditorService = game:GetService("ScriptEditorService")
local Template = {}
Template.Pattern = "ser%-(%w+)%-"
Template.Content = [[local %s = game:GetService("%s")]]

local function IsValidService(serviceName: string)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    return success and service
end

function Template:Match(stringToMatch: string): string?
    return string.match(stringToMatch, Template.Pattern)
end

function Template:Execute(document: ScriptDocument, line: string, tag: string?)
    if (IsValidService(tag)) then
        local content = string.format(Template.Content, tag, tag)
        local lineNumber, _, _, _ = document:GetSelection()
        document:EditTextAsync(content, lineNumber, 1, lineNumber, string.len(line) + 1)
    end
end

return Template