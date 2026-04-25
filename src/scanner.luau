local types = require("./types")

local function scanner<TokenType>(language: types.Language<TokenType>)
	local function scan(source: string)
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
	end

	return scan
end

return scanner
