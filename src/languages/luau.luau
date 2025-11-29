local types = require "../types"

type TokenType = "number" | "string" | "comment" | "whitespace" | "keyword" | "builtin" | "iden" | string

-- local NUMBER1 = "^[%+%-]?%d+%.?%d*[eE][%+%-]?%d+"
-- local NUMBER2 = "^[%+%-]?%d+%.?%d*"
local IDEN = "^[%a_][%w_]*"
local WHITESPACE = "^%s+"

local NUMBER_DECI = "^%d*%.?%d+"
local NUMBER_HEX = "^0x[%da-fA-F]+"
local NUMBER_BIN = "^0b[01]+"
local NUMBER_SCI = "^%d+%.?%d*[eE][%+%-]?%d+"

local STRING = [[^(['"]).-[^\](\*)%2%1]]
local STRING_INCOMPLETE = "^(['\"]).-.*"
local STRING_EMPTY = "^(['\"])%1"
local STRING_ESCAPE = [[^(['"])(\*)%2%1]]

local MULTILINE_STRING = "^%[(=*)%[.-%]%1%]"
local MULTILINE_STRING_INCOMPLETE = "^%[%[.-.*"
local MULTILINE_COMMENT = "^%-%-%[(=*)%[.-%]%1%]"
local MULTILINE_COMMENT_INCOMPLETE = "^%-%-%[%[.-.*"

local SINGLELINE_COMMENT = "^%-%-.-\n"
local SINGLELINE_COMMENT_INCOMPLETE = "^%-%-.-.*"

local lua_keyword = {
	["and"] = true,
	["break"] = true,
	["do"] = true,
	["else"] = true,
	["elseif"] = true,
	["end"] = true,
	["false"] = true,
	["for"] = true,
	["function"] = true,
	["if"] = true,
	["in"] = true,
	["local"] = true,
	["nil"] = true,
	["not"] = true,
	["while"] = true,
	["or"] = true,
	["repeat"] = true,
	["return"] = true,
	["then"] = true,
	["true"] = true,
	["self"] = true,
	["until"] = true,
	["continue"] = true,
}
local lua_builtin = {
	["assert"] = true,
	["collectgarbage"] = true,
	["error"] = true,
	["_G"] = true,
	["gcinfo"] = true,
	["getfenv"] = true,
	["getmetatable"] = true,
	["ipairs"] = true,
	["loadstring"] = true,
	["newproxy"] = true,
	["next"] = true,
	["pairs"] = true,
	["pcall"] = true,
	["print"] = true,
	["rawequal"] = true,
	["rawget"] = true,
	["rawset"] = true,
	["select"] = true,
	["setfenv"] = true,
	["setmetatable"] = true,
	["tonumber"] = true,
	["tostring"] = true,
	["type"] = true,
	["unpack"] = true,
	["_VERSION"] = true,
	["xpcall"] = true,
	["require"] = true,
	["typeof"] = true,
}

local function token_dump(tok: string): (TokenType, string)
	return tok, tok
end

local function number_dump(tok: string): (TokenType, string)
	return "number", tok
end

local function string_dump(tok: string): (TokenType, string)
	return "string", tok
end

local function comment_dump(tok: string): (TokenType, string)
	return "comment", tok
end

local function whitespace_dump(tok: string): (TokenType, string)
	return "whitespace", tok
end

local function lua_vdump(tok: string): (TokenType, string)
	if lua_keyword[tok] then
		return "keyword", tok
	elseif lua_builtin[tok] then
		return "builtin", tok
	else
		return "iden", tok
	end
end

return table.freeze {
	{ pattern = IDEN, func = lua_vdump },

	{ pattern = WHITESPACE, func = whitespace_dump },

	{ pattern = NUMBER_BIN, func = number_dump },
	{ pattern = NUMBER_HEX, func = number_dump },
	{ pattern = NUMBER_SCI, func = number_dump },
	{ pattern = NUMBER_DECI, func = number_dump },

	{ pattern = STRING_EMPTY, func = string_dump },
	{ pattern = STRING_ESCAPE, func = string_dump },
	{ pattern = STRING, func = string_dump },
	{ pattern = STRING_INCOMPLETE, func = string_dump },
	{ pattern = MULTILINE_STRING, func = string_dump },
	{ pattern = MULTILINE_STRING_INCOMPLETE, func = string_dump },

	{ pattern = MULTILINE_COMMENT, func = comment_dump },
	{ pattern = MULTILINE_COMMENT_INCOMPLETE, func = comment_dump },
	{ pattern = SINGLELINE_COMMENT, func = comment_dump },
	{ pattern = SINGLELINE_COMMENT_INCOMPLETE, func = comment_dump },

	{ pattern = "^==", func = token_dump },
	{ pattern = "^~=", func = token_dump },
	{ pattern = "^<=", func = token_dump },
	{ pattern = "^>=", func = token_dump },
	{ pattern = "^+=", func = token_dump },
	{ pattern = "^-=", func = token_dump },
	{ pattern = "^*=", func = token_dump },
	{ pattern = "^/=", func = token_dump },
	{ pattern = "^//=", func = token_dump },
	{ pattern = "^//", func = token_dump },
	{ pattern = "^%.%.%.", func = token_dump },
	{ pattern = "^%.%.", func = token_dump },
	{ pattern = "^.", func = token_dump },
} :: types.Language<TokenType>
