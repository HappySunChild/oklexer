# oklexer
An ok lexer for Luau.

## Usage Example
```luau
local oklexer = require "path/to/oklexer"
local LuauLexer = oklexer.Lexer(oklexer.languages.luau)

local luau_source = [[
-- cool comment
local bin = 0b101011
local hex = 0x123456790FAB -- fabulous

local function add(a, b) return a + b end
]]

for token_type, content in LuauLexer:scan(luau_source) do
	if token_type == "whitespace" then
		continue
	end

	print(`{token_type} -> '{content}'`)
end
```