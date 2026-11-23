-- Functions and Definitions

def hello := "Hello"
def lean : String := "Lean"

#eval String.append hello (String.append ", " lean)

-- defining functions

def add1 (n : Nat) : Nat := n + 1

#guard add1 0 = 1

def maximum (n : Nat) (k : Nat) : Nat :=
  if n >= k then
    n
  else k

#guard maximum 0 0 = 0
#guard maximum 0 1 = 1
#guard maximum 1 0 = 1

def spaceBetween (before : String) (after : String) : String :=
  String.append before (String.append " " after)

#guard spaceBetween hello lean = "Hello Lean"

-- exercises

def joinStringsWith (sep : String) (before : String) (after : String) : String :=
  String.append before (String.append sep after)

#guard joinStringsWith ", " hello lean = "Hello, Lean"

-- String → String → String
#check joinStringsWith ": "

def volume (height : Nat) (width : Nat) (depth : Nat) : Nat :=
  height * width * depth

#guard volume 10 20 30 = 6000

-- defining types

def Str : Type := String

def aStr : Str := "This is a string"

def NaturalNumber : Type := Nat

--def thirtyEight : NaturalNumber := 38
def thirtyEight : NaturalNumber := (38 : Nat)

abbrev MyNaturalNumber : Type := Nat

def fortyTwo : MyNaturalNumber := 42





