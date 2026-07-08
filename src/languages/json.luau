const types = require("../types")

type TokenType = "string" | "number" | "bool" | "null" | "whitespace" | string

const WHITESPACE = "^%s+"

const STRING = '^"[^"]*"'
const BOOL_TRUE = "^true"
const BOOL_FALSE = "^false"
const NULL = "^null"

const NUMBER_INT = "^%d+"
const NUMBER_DEC = "^%d+%.%d+"
const NUMBER_SCI = "^%d+%.?%d*[eE]%-?%d+"

const function yield_token(tok: string): (TokenType, string)
	return tok, tok
end

const function yield_whitespace(tok: string): (TokenType, string)
	return "whitespace", tok
end

const function yield_string(tok: string): (TokenType, string)
	return "string", tok
end

const function yield_bool(tok: string): (TokenType, string)
	return "bool", tok
end

const function yield_null(tok: string): (TokenType, string)
	return "null", tok
end

const function yield_number(tok: string): (TokenType, string)
	return "number", tok
end

return {
	{ pattern = WHITESPACE, func = yield_whitespace },

	{ pattern = NUMBER_SCI, func = yield_number },
	{ pattern = NUMBER_DEC, func = yield_number },
	{ pattern = NUMBER_INT, func = yield_number },

	{ pattern = BOOL_TRUE, func = yield_bool },
	{ pattern = BOOL_FALSE, func = yield_bool },
	{ pattern = NULL, func = yield_null },

	{ pattern = STRING, func = yield_string },

	{ pattern = "^.", func = yield_token },
} :: types.Language<TokenType>
