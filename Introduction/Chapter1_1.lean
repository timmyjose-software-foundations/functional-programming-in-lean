-- Evaluating expressions

#eval 1 + 2
#eval 2 * 4 + 3
#eval 1 + 2 * 5

#eval String.append "Hello" ", wworld"

#eval String.append "great " (String.append "oak " "tree")

#eval String.append "it is " (if 1 > 2 then "yes" else "no")

-- exercises

#guard 42 + 19 = 61
#guard String.append "A" (String.append "B" "C") = "ABC"
#guard String.append (String.append "A" "B") "C" = "ABC"
#guard (if 3 == 3 then 5 else 7) = 5
#guard (if 3 == 4 then "equal" else "not equal") = "not equal"
