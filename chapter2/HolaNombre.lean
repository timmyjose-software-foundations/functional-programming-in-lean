def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout
  stdout.putStrLn "Como se llama?"
  let input ← stdin.getLine
  let name := input.dropEndWhile Char.isWhitespace
  stdout.putStrLn s!"Hola, {name}"

#eval "Hello!!".dropEndWhile (. == '!')
#eval "Hello!!!".dropEndWhile (fun c => c == '!')
#eval "Hello      ".dropEndWhile (fun c => not (c.isAlphanum))
