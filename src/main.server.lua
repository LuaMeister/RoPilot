
local ScriptEditorService = game:GetService("ScriptEditorService")

local scriptTemplates = {}

ScriptEditorService.TextDocumentDidChange:Connect(function(document: ScriptDocument)
    local line: string = document:GetLine()

    for _, template in pairs(scriptTemplates) do
        local match: string? = template:Match(line)
        if (match) then
            template:Execute(document, line, match)
        end
    end
end)

for n: number, template: ModuleScript in pairs(script.Parent.templates:GetChildren()) do
    scriptTemplates[n] = require(template)
end