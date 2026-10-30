def twice (action : IO Unit) : IO Unit := do
  action
  action

#eval twice (IO.println "Hi")

def nTimes (action : IO Unit) : Nat -> IO Unit
  | 0 => pure ()
  | n + 1 => do
    action
    nTimes action n

#eval nTimes (IO.println "Hey there!") 5

-- IO actions are first-class

def countdown : Nat -> List (IO Unit)
  | 0 => [IO.println "Blast off!"]
  | n + 1 => IO.println s!"{n + 1}" :: countdown n

def from5 : List (IO Unit) := countdown 5

#guard from5.length == 6

def runActions : List (IO Unit) -> IO Unit
  | [] => pure ()
  | act :: acts => do
    act
    runActions acts

#eval runActions from5

-- exercise

def main : IO Unit := do
-- expression evaluated
  let englishGreeting := IO.println "Hello"
  -- IO action being executed
  IO.println "Bonjour!"
  -- IO action being executed
  englishGreeting
