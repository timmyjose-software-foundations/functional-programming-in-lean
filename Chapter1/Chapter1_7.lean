-- Characters, Strings, and Slices

#eval "Hello, " ++ "world"
#eval String.push "Hello" '!'
#eval "Hello".push '!'

#eval (("small tortoiseshell".drop 6).dropEnd 5).copy

#eval "red admiral".dropEndWhile 'l'
#eval "the the butterfly".dropWhile "the "
#eval ("a gray grayling".drop 2).dropWhile "gray "

#eval ("red admiral".dropEndWhile Char.isAlpha).copy
