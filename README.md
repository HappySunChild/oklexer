# oklexer
An ok lexer written in Luau.

## Usage Example
```luau
local oklexer = require("oklexer")

local luau_source = [[
-- cool comment
local bin = 0b101011
local hex = 0x123456790FAB -- fabulous

local function add(a, b) return a + b end
]]

local consume = oklexer.scanner(oklexer.languages.luau, luau_source)

for token_type, content in consume do
	if token_type == "whitespace" then
		continue
	end

	print(`{token_type} -> '{content}'`)
end

```