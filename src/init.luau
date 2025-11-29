local oklexer = table.freeze {
	Lexer = require "@self/Lexer",

	languages = table.freeze {
		luau = require "@self/languages/luau",
		json = require "@self/languages/json",
	},
}

return oklexer
