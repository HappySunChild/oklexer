type TokenMatch<TokenType> = { pattern: string, func: (string) -> (TokenType, string) }

export type Language<TokenType> = { TokenMatch<TokenType> }
export type Lexer<Token = string> = {
	scan: (Lexer<Token>, source: string) -> () -> (Token, string),
}

return nil
