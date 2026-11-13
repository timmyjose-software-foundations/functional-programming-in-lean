-- Datatypes and Patterns

-- inductive Bool : Type where
--   | true : Bool
--   | false : Bool

def isZero (n : Nat) : Bool :=
  match n with
    | .zero => true
    | _ => false

#guard isZero 0
#guard not (isZero 1)

def pred (n : Nat) : Nat :=
  match n with
    | .zero => .zero
    | .succ k => k

#guard pred 0 == 0
#guard pred 1 == 0
#guard pred 100 == 99

structure Point3D : Type where
  x : Float
  y : Float
  z : Float

def depth (p : Point3D) : Float :=
  match p with
    | { x := _x, y := _y, z := d} => d

#guard depth  { x := 1, y := 2, z := 3} == 3

def even (n : Nat) : Bool :=
  match n with
    | .zero => true
    | .succ k => not (even k)

#guard even 0
#guard not (even 1)
#guard even 100

def plus (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => n
    | .succ k => .succ (plus n k)

#guard plus 0 0 == 0
#guard plus 1 0 == 1
#guard plus 0 1 == 1
#guard plus 2 3 == 5
#guard plus 3 2 == 5

def times (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => .zero
    | .succ k => plus n (times n k)

#guard times 1 0 == 0
#guard times 0 1 == 0
#guard times 1 1 == 1
#guard times 1 2 == 2
#guard times 2 1 == 2
#guard times 2 3 == 6
#guard times 3 2 == 6

def minus (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => n
    | .succ k => pred (minus n k)

#guard minus 0 0 == 0
#guard minus 1 0 == 1
#guard minus 0 1 == 0
#guard minus 3 1 == 2
#guard minus 1 3 == 0
