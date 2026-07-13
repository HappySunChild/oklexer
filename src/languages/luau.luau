const types = require("../types")

type TokenType = "number" | "string" | "comment" | "whitespace" | "keyword" | "builtin" | "iden" | "operator" | string

const IDEN = "^[%a_][%w_]*"
const WHITESPACE = "^%s+"

const NUMBER_DECI = "^%d*%.?%d+"
const NUMBER_HEX = "^0x[%da-fA-F]+"
const NUMBER_BIN = "^0b[01]+"
const NUMBER_SCI = "^%d+%.?%d*[eE][%+%-]?%d+"

const STRING = [[^(['"]).-[^\](\*)%2%1]]
const STRING_INCOMPLETE = "^(['\"]).-.*"
const STRING_EMPTY = "^(['\"])%1"
const STRING_ESCAPE = [[^(['"])(\*)%2%1]]
const STRING_INTERPOLATED = "^`.-`"

const MULTILINE_STRING = "^%[(=*)%[.-%]%1%]"
const MULTILINE_STRING_INCOMPLETE = "^%[%[.-.*"
const MULTILINE_COMMENT = "^%-%-%[(=*)%[.-%]%1%]"
const MULTILINE_COMMENT_INCOMPLETE = "^%-%-%[%[.-.*"

const SINGLELINE_COMMENT = "^%-%-.-\n"
const SINGLELINE_COMMENT_INCOMPLETE = "^%-%-.-.*"

const LUAU_KEYWORDS = {
	["local"] = true,
	["const"] = true,
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
	["nil"] = true,
	["not"] = true,
	["while"] = true,
	["or"] = true,
	["repeat"] = true,
	["return"] = true,
	["then"] = true,
	["true"] = true,
	["until"] = true,
	["continue"] = true,
}
const LUAU_OPERATORS = {
	["="] = true,
	["+"] = true,
	["-"] = true,
	["*"] = true,
	["/"] = true,
	["^"] = true,
	["%"] = true,
	["=="] = true,
	["~="] = true,
	["<="] = true,
	[">="] = true,
	["+="] = true,
	["-="] = true,
	["*="] = true,
	["/="] = true,
	["^="] = true,
	["%="] = true,
	["//="] = true,
	["//"] = true,
	[".."] = true,
	["..="] = true,
}

const function yield_token(tok: string): (TokenType, string)
	if LUAU_OPERATORS[tok] then
		return "operator", tok
	end

	return tok, tok
end

const function yield_number(tok: string): (TokenType, string)
	return "number", tok
end

const function yield_string(tok: string): (TokenType, string)
	return "string", tok
end

const function yield_comment(tok: string): (TokenType, string)
	return "comment", tok
end

const function yield_whitespace(tok: string): (TokenType, string)
	return "whitespace", tok
end

const function yield_lua(tok: string): (TokenType, string)
	if LUAU_KEYWORDS[tok] then
		return "keyword", tok
	else
		return "iden", tok
	end
end

return {
	{ pattern = WHITESPACE, func = yield_whitespace },

	{ pattern = IDEN, func = yield_lua },

	{ pattern = NUMBER_BIN, func = yield_number },
	{ pattern = NUMBER_HEX, func = yield_number },
	{ pattern = NUMBER_SCI, func = yield_number },
	{ pattern = NUMBER_DECI, func = yield_number },

	{ pattern = STRING_EMPTY, func = yield_string },
	{ pattern = STRING_ESCAPE, func = yield_string },
	{ pattern = STRING, func = yield_string },
	{ pattern = STRING_INCOMPLETE, func = yield_string },
	{ pattern = MULTILINE_STRING, func = yield_string },
	{ pattern = MULTILINE_STRING_INCOMPLETE, func = yield_string },
	{ pattern = STRING_INTERPOLATED, func = yield_string },

	{ pattern = MULTILINE_COMMENT, func = yield_comment },
	{ pattern = MULTILINE_COMMENT_INCOMPLETE, func = yield_comment },
	{ pattern = SINGLELINE_COMMENT, func = yield_comment },
	{ pattern = SINGLELINE_COMMENT_INCOMPLETE, func = yield_comment },

	{ pattern = "^==", func = yield_token },
	{ pattern = "^~=", func = yield_token },
	{ pattern = "^<=", func = yield_token },
	{ pattern = "^>=", func = yield_token },
	{ pattern = "^+=", func = yield_token },
	{ pattern = "^-=", func = yield_token },
	{ pattern = "^*=", func = yield_token },
	{ pattern = "^/=", func = yield_token },
	{ pattern = "^//=", func = yield_token },
	{ pattern = "^%*=", func = yield_token },
	{ pattern = "^%%=", func = yield_token },
	{ pattern = "^//", func = yield_token },
	{ pattern = "^%.%.%.", func = yield_token },
	{ pattern = "^%.%.", func = yield_token },
	{ pattern = "^%.%.=", func = yield_token },
	{ pattern = "^.", func = yield_token },
} :: types.Language<TokenType>
