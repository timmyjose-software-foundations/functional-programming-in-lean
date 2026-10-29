-- Characters, Strings, and Slices

#eval "Hello" ++ ", " ++ "world"
#eval String.push "Hello" '!'
#eval "Hello".push '!'

-- the `copy` call create a new `String`, otherwise the intermediates are `String.Slice`
#eval (("small tortoiseshell".drop 6).dropEnd 5).copy

-- String.Slice
#check ("hello world".dropEndWhile Char.isAlphanum)
-- String
#check ("hello world".dropEndWhile Char.isAlphanum).copy

#eval "red admiral".dropEndWhile 'l'
#eval "red admiral".dropWhile 'l'
#eval "the the red butterfly".dropWhile "the "
#eval ("a gray grayling".drop 2).dropWhile "gray "

#eval ("red admiral".dropEndWhile Char.isAlpha).copy
