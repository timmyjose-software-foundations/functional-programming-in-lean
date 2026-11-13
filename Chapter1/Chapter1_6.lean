-- Polymorphism

structure PPoint (α : Type): Type where
  x : α
  y : α
  deriving BEq

def natOrigin : PPoint Nat := { x := 0, y := 0}
def floatOrigin : PPoint Float := { x := 0.0, y := 0.0 }

def replaceX (p : PPoint α) (newX : α) : PPoint α :=
  { p with x := newX }

def point1 : PPoint Nat := { x := 1, y := 2}
def point2 : PPoint Float := { x := 0.12, y := -1.23 }

#guard replaceX point1 12 == { x := 12, y := 2 }
#guard replaceX point2 1.2 == { x := 1.2, y := -1.23 }

inductive Sign : Type where
  | neg
  | pos

def posOrNegThree (sign : Sign) : match sign with | .neg => Int | .pos => Nat :=
  match sign with
    | .neg => -3
    | .pos => 3

#guard posOrNegThree Sign.pos == 3
#guard posOrNegThree Sign.neg == -3

-- inductive List (α : Type) : Type where
--   | nil : List α
--   | cons : α → List α → List α

def explicitPrimesUnder10 : List Nat :=
  List.cons 2 (List.cons 3 (List.cons 5 (List.cons 7 List.nil)))

#guard explicitPrimesUnder10 == [2, 3, 5, 7]

def length (xs : List α) : Nat :=
  match xs with
    | [] => 0
    | _ :: ys => Nat.succ (length ys)

#guard length explicitPrimesUnder10 == 4

#check List.length (α := Int)

-- inductive Option α : Type where
--   | none : Option α
--   | some : α → Option α

-- def List.head? (xs : List α) : Option α :=
--   match xs with
--     | [] => .none
--     | y :: _ => .some y

#guard List.head? ([] : List Nat) == .none
#guard List.head? [1] == .some 1

-- structure Prod α β : Type where
--   fst : α
--   snd : β

def ones : String × Int := ("eins", 1)
def alsoOnes : String × Int := { fst := "eins", snd := 1 }

#guard ones == alsoOnes

def sevens : String × Int × Nat := ("sevens", 7, 4 + 3)
def alsoSevens : String × (Int × Nat) := ("sevens", (7, 4 + 3))

#guard sevens == alsoSevens

-- inductive Sum α β : Type where
--   | inl : α → Sum α β
--   | inr : β → Sum α β

def PetName : Type := String ⊕ String

def animals : List PetName :=
  [Sum.inl "Rufus", Sum.inr "Sparkles", Sum.inl "Goodboy", Sum.inl "Toby", Sum.inr "Pickles"]

def howManyDogs (pets : List PetName) : Nat :=
  match pets with
    | [] => 0
    | Sum.inl _ :: ps => 1 + howManyDogs ps
    | Sum.inr _ :: ps => howManyDogs ps

#guard howManyDogs animals == 3

def howManyCats (pets : List PetName) : Nat :=
  match pets with
    | [] => 0
    | Sum.inl _ :: ps => howManyCats ps
    | Sum.inr _ :: ps => 1 + howManyCats ps


#guard howManyCats animals == 2

-- inductive Unit : Type where
--   | unit : Unit

inductive NoAnnotArithExpr (ann : Type) : Type where
  | int :  Int →  NoAnnotArithExpr ann
  | plus : NoAnnotArithExpr ann → NoAnnotArithExpr ann → NoAnnotArithExpr ann
  | times : NoAnnotArithExpr ann → NoAnnotArithExpr ann → NoAnnotArithExpr ann
  | minus : NoAnnotArithExpr ann →  NoAnnotArithExpr ann → NoAnnotArithExpr ann

def e1 : NoAnnotArithExpr Unit := .int 42

inductive ArithExpr (ann : Type) : Type where
  | int : ann → Int →  ArithExpr ann
  | plus : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | times : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | minus : ann → ArithExpr ann →  ArithExpr ann → ArithExpr ann

def e2 : ArithExpr Unit := .int () 42

-- exercises
-- Write a function to find the last entry in a list. It should return an Option.

def List.last? (xs : List α) : Option α :=
  match xs with
    | [] => .none
    | [x] => .some x
    | _ :: xs => List.last? xs

#guard List.last? ([] : List Nat) == .none
#guard List.last? [1] == .some 1
#guard List.last? [1, 2, 3, 4, 5] == .some 5


-- Write a function that finds the first entry in a list that satisfies a given predicate. Start the definition with def List.findFirst? {α : Type} (xs : List α) (predicate : α → Bool) : Option α := ….

def List.findFirst? (xs : List α) (predicate : α → Bool) : Option α :=
  match xs with
    | [] => .none
    | x :: xs => if predicate x then (.some x) else List.findFirst? xs predicate

#guard List.findFirst? [1, 2, 3, 4, 5] (fun x =>  x % 2 == 0) == .some 2
#guard List.findFirst? [1, 2, 3, 4, 5] (fun x => Nat.mod x 2 == 0) == .some 2
#guard List.findFirst? [1, 3, 5, 7] (fun x => x % 2 == 0) == .none

-- Write a function Prod.switch that switches the two fields in a pair for each other. Start the definition with def Prod.switch {α β : Type} (pair : α × β) : β × α := ….

def Prod.switch (pair : α × β) : β × α :=
  match pair with
    | (f, s) => (s, f)

#guard Prod.switch (1, true) == (true, 1)
#guard Prod.switch ("hello", (false, 1.0)) == ((false, 1.0), "hello")


-- Rewrite the PetName example to use a custom datatype and compare it to the version that uses Sum.

inductive PetName' : Type where
  | dog : (name : String) → PetName'
  | cat : (name : String) → PetName'

def pets : List PetName' := [
  .dog "Rufus", .cat "Sparkles", .dog "Goodboy", .dog "Toby", .cat "Pickles"
]

def howManyDogs' (pets : List PetName') : Nat :=
  match pets with
    | [] => 0
    | .dog _ :: ps => 1 + howManyDogs' ps
    | _ :: ps => howManyDogs' ps

#guard howManyDogs' pets == 3

-- Write a function zip that combines two lists into a list of pairs. The resulting list should be as long as the shortest input list. Start the definition with def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) := ….

def zip (xs : List α) (ys : List β) : List (α × β) :=
  match xs, ys with
    | x :: xs, y :: ys => (x, y) :: zip xs ys
    | _, _ => []

#guard zip ([] : List Nat) ([] : List Nat) == []
#guard zip ([] : List Nat) [true] == []
#guard zip [1, 2] ([] : List Bool) == []
#guard zip [1, 2, 3] [true, false, true] == [(1, true), (2, false), (3, true)]
#guard zip [1, 2] [true, false, true] == [(1, true), (2, false)]

-- Write a polymorphic function take that returns the first n entries in a list, where n is a Nat.
-- If the list contains fewer than n entries, then the resulting list should be the entire input list.
-- #eval take 3 ["bolete", "oyster"] should yield ["bolete", "oyster"], and #eval take 1 ["bolete", "oyster"] should yield ["bolete"].

def take {α : Type u} (n : Nat) (xs : List α) : List α :=
  match n, xs with
    | 0, _ => []
    | _, [] => []
    | n + 1, x :: xs => x :: take n xs

#guard take 0 ([] : List Nat) = []
#guard take 10 ([] : List Nat) = []
#guard take 0 [1, 2, 3, 4, 5] = []
#guard take 10 [1, 2, 3, 4, 5] = [1, 2, 3, 4, 5]
#guard take 2 [1, 2, 3, 4, 5] = [1, 2]
#guard take 5 [1, 2, 3, 4, 5] = [1, 2, 3, 4, 5]

-- Using the analogy between types and arithmetic, write a function that distributes products over sums. In other words, it should have type α × (β ⊕ γ) → (α × β) ⊕ (α × γ).

def  productsOverSums {α β γ : Type u} (input : α × (β ⊕ γ)) : (α × β) ⊕ (α × γ) :=
  match input with
    | (a, .inl b) => .inl (a, b)
    | (a, .inr c) => .inr (a, c)

def inp1 : Nat × (Bool ⊕ String) := (1, .inl true)
def inp2 : Nat × (Bool ⊕ String) := (1, .inr "hello")

#guard productsOverSums inp1 = .inl (1, true)
#guard productsOverSums inp2 = .inr (1, "hello")

-- Using the analogy between types and arithmetic, write a function that turns multiplication by two into a sum. In other words, it should have type Bool × α → α ⊕ α.

def multBy2ToSum {α : Type u} (input : Bool × α) : α ⊕ α :=
  match input with
    | (true, x) => .inl x
    | (false, x) => .inr x

#guard multBy2ToSum (true, 1) = .inl 1
#guard multBy2ToSum (false, 1) = .inr 1
