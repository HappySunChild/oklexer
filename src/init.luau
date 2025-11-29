local oklexer = table.freeze {
	Lexer = require "@self/Lexer",

	languages = table.freeze {
		luau = require "@self/languages/luau",
	},
}

return oklexer
