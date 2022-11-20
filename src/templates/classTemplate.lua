
local ScriptEditorService = game:GetService("ScriptEditorService")
local Template = {}
Template.Pattern = "class%-(%w+)%-"
Template.Content = [[

local %s = {}
%s.__index = %s

function %s.new()
    local new%s = setmetatable(%s, {})

    return new%s
end

return %s]]

function Template:Match(stringToMatch: string): string?
    return string.match(stringToMatch, Template.Pattern)
end

function Template:Execute(document: ScriptDocument, line: string, tag: string?)
    local content = ""

    if (tag ~= nil) then
        content = string.format(Template.Content, tag, tag, tag, tag, tag, tag, tag, tag)
    else
        content = Template.Content
    end

    local LineNumber, _, _, _ = document:GetSelection()
    document:EditTextAsync(content, LineNumber, 1, LineNumber, string.len(line) + 1)
end

return Template