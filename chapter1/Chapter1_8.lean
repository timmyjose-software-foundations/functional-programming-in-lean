-- Additional Conveniences

-- automatic implicit parameters
def length {α : Type} (xs : List α) : Nat :=
  match xs with
    | [] => .zero
    | _ :: ys => .succ (length ys)

#guard length ([] : List Int) == 0
#guard length [1, 2, 3] == 3

-- with automatic implicits
def length' (xs : List α) : Nat :=
  match xs with
    | [] => .zero
    | _ :: ys => .succ (length' ys)

#guard length' ([] : List String) == 0
#guard length' ["Hello", "world"] == 2

-- pattern-matching definitions (a la OCaml)

def length'' : List α -> Nat
  | [] => .zero
  | _ :: ys => .succ (length'' ys)

#guard length'' ([] : List Bool) == 0
#guard length'' [true, false, false, true, true] == 5

-- we can match against multiple parameters with this syntax
def drop (n : Nat) (xs : List α) : List α :=
  match n with
    | .zero => xs
    | .succ k => match xs with | [] => [] | _ :: ys => drop k ys

#guard drop 0 ([] : List Int) == []
#guard drop 1 ([] : List Int) == []
#guard drop 1 [1] == []
#guard drop 2 [1] == []
#guard drop 1 [1, 2, 3] == [2, 3]
#guard drop 100 [1, 2, 3] == []
#guard drop 3 [1, 2, 3] == []

def drop' : Nat -> List α -> List α
  | .zero, xs => xs
  | .succ _, [] => []
  | .succ k, _ :: ys => drop' k ys

#guard drop' 0 ([] : List Int) == []
#guard drop' 1 ([] : List Int) == []
#guard drop' 1 [1] == []
#guard drop' 2 [1] == []
#guard drop' 1 [1, 2, 3] == [2, 3]
#guard drop' 100 [1, 2, 3] == []
#guard drop' 3 [1, 2, 3] == []

-- so this works now, using this syntax (unlike the previous version with the explicit body)
def zip : List α -> List β -> List (α × β)
  | _, [] => []
  | [], _ => []
  | x :: xs, y :: ys => (x, y) :: zip xs ys

#guard zip ([] : List Nat) ([] : List String) == []
#guard zip ([] : List Nat) ["Hello", "world"] == []
#guard zip [1, 2, 3, 4, 5] ([] : List String) == []
#guard zip [1, 2, 3] ["hello", "world"] == [(1, "hello"), (2, "world")]
#guard zip [1, 2, 3] ["hello", "world", "again"] == [(1, "hello"), (2, "world"), (3, "again")]

def fromOption (default : α) : Option α -> α
  | .none => default
  | .some val => val

#guard fromOption 42 .none == 42
#guard fromOption 42 (.some 100) == 100

#eval (some "salmonberry").getD ""
#eval (.none : Option String).getD "default"

-- Local Definitions

def unzip : List (α × β) -> List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) := unzip xys
    (x :: xs, y :: ys)

#guard unzip ([] : List (Int × String)) == ([], [])
#guard unzip [(1, "eins")] == ([1], ["eins"])
#guard unzip [(1, "hello"), (2, "world")] == ([1, 2], ["hello", "world"])

-- Just like in Ocaml, recursive `let` (but not `def`) requires `rec`
def reverse (xs : List α) : List α :=
  let rec helper : List α -> List α -> List α
    | [], acc => acc
    | x :: xs, acc => helper xs (x :: acc)
  helper xs []

#guard reverse ([] : List Nat) == []
#guard reverse [1] == [1]
#guard reverse [1, 2] == [2, 1]
#guard reverse [1, 2, 3, 4, 5] == [5, 4, 3, 2, 1]

-- Simultaneous matching

def drop'' (n : Nat) (xs : List α) : List α :=
  match  n, xs with
    | 0, ys => ys
    | _,  [] => []
    | k + 1, _ :: ys => drop k ys

#guard drop'' 0 ([] : List Int) == []
#guard drop'' 1 ([] : List Int) == []
#guard drop'' 1 [1] == []
#guard drop'' 2 [1] == []
#guard drop'' 1 [1, 2, 3] == [2, 3]
#guard drop'' 100 [1, 2, 3] == []
#guard drop'' 3 [1, 2, 3] == []

def sameLength (xs : List α) (ys : List β) : Bool :=
  match xs, ys with
    | [], [] => true
    | _, [] => false
    | [], _ => false
    | _ :: xs, _ :: ys => sameLength xs ys

#guard sameLength ([] : List Nat) ([] : List String)
#guard sameLength [1] ([] : List String) == false
#guard sameLength ([] : List Nat)  ["hello", "world"] == false
#guard sameLength [1, 2, 3 ] ["hello", "world", "again"]
#guard sameLength [1, 2, 3] [1, 2, 3]


-- Natural Number patterns

def even (n : Nat) : Bool :=
  match n with
    | .zero => true
    | .succ k => not (even k)

#guard even 0 == true
#guard even 1 == false
#guard even 10 == true
#guard even 11 == false

def even' : Nat → Bool
    | 0 => true
    | k + 1 => not (even k)

#guard even' 0 == true
#guard even' 1 == false
#guard even' 10 == true
#guard even' 11 == false

def halve (n : Nat) : Nat :=
  match n with
    | .zero => .zero
    | .succ .zero => .zero
    | .succ (.succ k) => halve k + 1

#guard halve 0 == 0
#guard halve 1 == 0
#guard halve 2 == 1
#guard halve 3 == 1

def halve' : Nat → Nat
  | 0 => 0
  | 1 => 0
  | n + 2 => halve' n + 1

#guard halve' 0 == 0
#guard halve' 1 == 0
#guard halve' 2 == 1
#guard halve' 3 == 1

-- Anonymous functions (`fun` and λ are synonyms)
#check fun x => x + 1
#check fun (x : Nat) => x + 1
#check fun {α : Type} (x : α) => x
#check λ x => x + 2
#check λ (x : Nat) => x + 2
#check λ {α : Type} (x : α) => x

#check fun | Nat.zero => none | Nat.succ k => some k

def double : Nat -> Nat
  | .zero => .zero
  | .succ k => double k + 2

#guard double 0 == 0
#guard double 1 == 2
#guard double 2 == 4

def double' : Nat -> Nat := fun
  | 0 => 0
  | k + 1 => double' k + 2

#guard double' 0 == 0
#guard double' 1 == 2
#guard double' 2 == 4

#guard (fun x => x * 2) 10 == 20
#guard ((. * 2) 10) == 20
#guard (λ x => x * 2) 10 == 20

-- Namespaces

def Nat.double (x : Nat) : Nat := x + x

#guard (5 : Nat).double == 10

namespace NewNamespace
  def triple (x : Nat) : Nat := 3 * x
  def quadruple (x : Nat) : Nat :=  2 * x + 2 * x
end NewNamespace

#check NewNamespace.triple
#check NewNamespace.quadruple

-- very OCamlish
def timesTwelve (x : Nat) : Nat :=
  open NewNamespace in
  quadruple (triple x)

#guard timesTwelve 3 == 36

open NewNamespace in
#check (triple)

-- if let (a la Rust)

inductive Inline : Type where
  | lineBreak
  | string : String -> Inline
  | emph : Inline -> Inline
  | strong : Inline -> Inline

def Inline.string? (inline : Inline) : Option String :=
  match inline with
    | string s => some s
    | _ => none

#guard Inline.string? (.string "Hello") == some "Hello"
#guard Inline.string? (.emph .lineBreak) == none

def Inline.string?' (inline : Inline) : Option String :=
  if let Inline.string s := inline then
    some s
  else
    none

#guard Inline.string?' (.string "World") == "World"
#guard Inline.string?' (.strong (.string "Again")) == none

-- String interpolation

#eval s!"Three fives is {NewNamespace.triple 5}"
