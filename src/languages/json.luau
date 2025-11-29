local types = require "../types"

type TokenType = "string" | "number" | "bool" | "null" | "whitespace" | string

-- {Type = 'string', Pattern = '"[^"]*"'},
-- {Type = 'constructor', Pattern = '(%w+)%([^)]*%)'}, -- [vec3(1, 1, 1), rgb(255, 255, 255)]

-- {Type = 'keyword', Pattern = 'true'},
-- {Type = 'keyword', Pattern = 'false'},
-- {Type = 'keyword', Pattern = 'null'},

-- {Type = 'number', Pattern = '0b[01]+'}, -- [0b1010, 0b0111]
-- {Type = 'number', Pattern = '0x%x+'}, -- [0xFF, 0x1AB]
-- {Type = 'number', Pattern = '%d*%.%d+'}, -- [1.54, .03]
-- {Type = 'number', Pattern = '%d+e%-?%d+'}, -- [1e4, 10e5]
-- {Type = 'number', Pattern = '%d+'}, -- [132, 10032]

-- {Type = 'parameter', Pattern = '%(([^)]+)%)'},

-- {Type = 'assignment', Pattern = ':'},
-- {Type = 'enum', Pattern = 'Enum%.%w+%.%w+'},
-- {Type = 'operator', Pattern = '[{}%(%)%[%]]+'}

local WHITESPACE = "^%s+"

local STRING = '^"[^"]*"'
local BOOL_TRUE = "^true"
local BOOL_FALSE = "^false"
local NULL = "^null"

local NUMBER_INT = "^%d+"
local NUMBER_DEC = "^%d+%.%d+"
local NUMBER_SCI = "^%d+%.?%d*[eE]%-?%d+"

local function dump_token(tok: string): (TokenType, string)
	return tok, tok
end

local function dump_whitespace(tok: string): (TokenType, string)
	return "whitespace", tok
end

local function dump_string(tok: string): (TokenType, string)
	return "string", tok
end

local function dump_bool(tok: string): (TokenType, string)
	return "bool", tok
end

local function dump_null(tok: string): (TokenType, string)
	return "null", tok
end

local function dump_number(tok: string): (TokenType, string)
	return "number", tok
end

return table.freeze {
	{ pattern = WHITESPACE, func = dump_whitespace },

	{ pattern = NUMBER_SCI, func = dump_number },
	{ pattern = NUMBER_DEC, func = dump_number },
	{ pattern = NUMBER_INT, func = dump_number },

	{ pattern = BOOL_TRUE, func = dump_bool },
	{ pattern = BOOL_FALSE, func = dump_bool },
	{ pattern = NULL, func = dump_null },

	{ pattern = STRING, func = dump_string },

	{ pattern = "^.", func = dump_token },
} :: types.Language<TokenType>
