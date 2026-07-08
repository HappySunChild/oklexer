const types = require("../types")

type TokenType = "number" | "variable" | "operator" | "open_paren" | "close_paren" | "whitespace" | string

const WHITESPACE = "^%s+"
const IDEN = "^[%a][%w]*"

const NUMBER_INT = "^%d+"
const NUMBER_DEC = "^%d*%.%d+"
const NUMBER_SCI = "^%d*%.?%d+[eE][%-%+]?%d+"
const NUMBER_HEX = "^0[xX][%da-fA-F]+"
const NUMBER_BIN = "^0[bB][01]+"
const NUMBER_OCT = "^0[oO][01234567]"

const OPEN_PAREN = "^%("
const CLOSE_PAREN = "^%)"

const OPERATOR = "^[%+%-%*/%^%%]"

const function new_yield(token_type: TokenType)
	return function(tok: string): (TokenType, string)
		return token_type, tok
	end
end

const function yield_token(tok: string): (TokenType, string)
	return tok, tok
end

const function yield_number(tok: string): (TokenType, string)
	return "number", tok
end

return {
	{ pattern = WHITESPACE, func = new_yield("whitespace") },

	{ pattern = IDEN, func = new_yield("variable") },

	{ pattern = OPERATOR, func = new_yield("operator") },

	{ pattern = NUMBER_BIN, func = yield_number },
	{ pattern = NUMBER_OCT, func = yield_number },
	{ pattern = NUMBER_HEX, func = yield_number },
	{ pattern = NUMBER_SCI, func = yield_number },
	{ pattern = NUMBER_DEC, func = yield_number },
	{ pattern = NUMBER_INT, func = yield_number },

	{ pattern = OPEN_PAREN, func = new_yield("open_paren") },
	{ pattern = CLOSE_PAREN, func = new_yield("close_paren") },

	{ pattern = "^.", func = yield_token },
} :: types.Language<TokenType>
