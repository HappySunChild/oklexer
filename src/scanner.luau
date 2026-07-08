const types = require("./types")

const function scanner<TokenType>(language: types.Language<TokenType>, source: string)
	const eof = string.len(source)

	local cursor = 0

	const function peek(): (TokenType?, string?, number)
		if cursor > eof then
			return nil, nil, cursor
		end

		for _, match in language do
			const start, finish = string.find(source, match.pattern, cursor)

			if start == nil or finish == nil then
				continue
			end

			const token_type, token_content = match.func(string.sub(source, start, finish))

			return token_type, token_content, finish + 1
		end

		error("invalid language; failed to match any defined patterns")
	end

	const function consume(): (TokenType, string)
		const token_type, token_content, next_cursor = peek()

		cursor = next_cursor

		return token_type, token_content
	end

	return consume, peek
end

return scanner
