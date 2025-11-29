local types = require "./types"

type Self<TokenType> = types.Lexer<TokenType> & {
	_language: types.Language<TokenType>,
}

local CLASS = table.freeze {
	scan = function<TokenType>(self: Self<TokenType>, source: string)
		local language = self._language

		local cursor = 0

		local iterator = function()
			for _, match in language do
				local pattern, func = match.pattern, match.func
				local start, finish = source:find(pattern, cursor)

				if start == nil then
					continue
				end

				cursor = finish + 1

				local token = source:sub(start, finish)

				return func(token)
			end

			return nil
		end

		return iterator
	end,
}
local METATABLE = table.freeze { __index = CLASS }

local function Lexer<TokenType>(language: types.Language<TokenType>): types.Lexer<TokenType>
	local new_lexer: Self<TokenType> = setmetatable({
		_language = language,
	}, METATABLE) :: any

	return new_lexer
end

return Lexer
