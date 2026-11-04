-- Functions and Definitions

def hello := "Hello"
def lean : String := "Lean"

#eval String.append hello (String.append ", " lean)

def add1 (n : Nat) : Nat := n + 1

#eval add1 1
#guard add1 1 == 2

def maximum (n : Nat) (k : Nat) : Nat :=
  if n >= k then
    n
  else
    k

#guard maximum 1 2 == 2
#guard maximum 2 1 == 2

def spaceBetween (before : String) (after : String) : String :=
  String.append before (String.append " " after)

#guard spaceBetween hello lean == "Hello Lean"

#check add1 -- add1 (n : Nat) : Nat
#check (add1) -- add1 : Nat → Nat

-- exercises

def joinStringsWith (sep : String) (before : String) (after : String) :=
  String.append before (String.append sep after)

#guard joinStringsWith ", " "one" "and another" == "one, and another"

-- What is the type of `joinStringsWith ": "? `String → String → String`
#check joinStringsWith ": "

def volume (height : Nat) (width : Nat) (depth : Nat) : Nat :=
  height * width * depth

#guard volume 10 20 30 == 6000

-- type aliases

def aStr : Type := String
def someStr : String := "Hello"

def NaturalNumber : Type := Nat

-- def thirtyEight : NaturalNumber := 38
def thirtyEight : NaturalNumber := (38 : Nat)

-- `abbrev` is always unfolded
abbrev N : Type := Nat

def fortyTwo : N := 42
