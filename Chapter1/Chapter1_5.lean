-- DataTypes and Patterns

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

#guard pred 0 = 0
#guard pred 1 = 0
#guard pred 2 = 1
#guard pred 839 = 838
#guard pred 5 = 4

structure Point3D : Type where
  x : Float
  y : Float
  z : Float

def point1 : Point3D := { x := 1.0, y := -2.01, z := 34.129 }

def depth (p : Point3D) : Float :=
  match p with
    | { x := _, y := _ , z := depth } => depth

#guard depth point1 = 34.129

-- recursive functions

def even (n : Nat) : Bool :=
  match n with
    | .zero => true
    | .succ k => not (even k)

#guard even 0
#guard not (even 1)
#guard even 2

def odd (n : Nat) : Bool :=
  match n with
    | .zero => false
    | .succ k => not (odd k)

#guard not (odd 0)
#guard odd 1
#guard not (odd 2)

def plus (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => n
    | .succ k => .succ (plus n k)

#guard plus 0 0 = 0
#guard plus 0 1 = 1
#guard plus 1 0 = 1
#guard plus 1 2 = 3
#guard plus 2 1 = 3
#guard plus 2 3 = 5

def times (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => .zero
    | .succ k => plus n (times n k)

#guard times 0 1 = 0
#guard times 1 0 = 0
#guard times 100 1 = 100
#guard times 100 1 = 100
#guard times 2 3 = 6
#guard times 3 2 = 6

def minus (n : Nat) (m : Nat) : Nat :=
  match m with
    | .zero => n
    | .succ k => pred (minus n k)

#guard minus 0 0 = 0
#guard minus 0 1 = 0
#guard minus 1 0 = 1
#guard minus 100 1 = 99
#guard minus 1 100 = 0
