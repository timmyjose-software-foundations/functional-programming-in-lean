-- Types

#eval (1 + 2 : Nat)
#eval (1 - 2 : Nat) -- 0
#eval (1 - 2 : Int) -- -1

#check (1 - 2) -- Nat
#check (1 - 2 : Int)  -- Int

-- #check String.append ["hello", ""] "world"
