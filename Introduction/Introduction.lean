-- This module serves as the root of the `Introduction` library.
-- Import modules here that should be built as part of the library.
import Introduction.Basic

def add1 (n : Nat) : Nat := n + 1

#eval add1 7
#guard add1 7 = 8

