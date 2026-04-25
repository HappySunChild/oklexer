local oklexer = table.freeze({
	scanner = require("@self/scanner"),

	languages = table.freeze({
		luau = require("@self/languages/luau"),
		json = require("@self/languages/json"),
	}),
})

return oklexer
