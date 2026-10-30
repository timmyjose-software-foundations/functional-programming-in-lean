def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout
  stdout.putStrLn "What is your name?"
  let input ← stdin.getLine
  let name := input.dropEndWhile Char.isWhitespace
  stdout.putStrLn s!"Hello and Welcome, {name}"
