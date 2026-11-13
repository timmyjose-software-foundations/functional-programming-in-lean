-- Structures

#check 1.2
#check -2.78128
#check 0.0
#check (0 : Float)

structure Point where
  x : Float
  y : Float
  deriving BEq

def origin : Point := { x := 0, y := 0 }

#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point): Point :=
  { x := p1.x + p2.x , y := p1.y + p2.y }

def floatPoint1 : Point := { x := 1.0, y := -2.0}
def floatPoint2 : Point := { x := -0.5, y := -0.5 }
def floatPoint3 : Point := { x := 3.0, y := 4.0 }

#guard addPoints floatPoint1 floatPoint2 == { x := 0.5, y := -2.5 }
#guard addPoints floatPoint1 origin == floatPoint1
#guard addPoints floatPoint2 origin == floatPoint2

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt ((p1.x - p2.x)^2 + (p1.y - p2.y)^2)

#eval distance floatPoint1 origin
#eval distance origin floatPoint3

structure Point3D where
  x : Float
  y : Float
  z : Float

def origin3D : Point3D := { x := 0, y := 0, z := 0 }
def p1 : Point3D := { x := 3.0, y := 4.0, z := 5.0 }

-- def zeroX (p : Point) : Point :=
--   { x := 0, y := p.y }

def zeroX (p : Point) : Point :=
  { p with x := 0 }

#guard zeroX floatPoint1 == { x := 0, y := -2.0 }
#guard zeroX floatPoint2 == { x := 0, y := -0.5 }

#check Point.mk 1.2 (-0.34)
#check (Point.mk)

structure Pair where
  mkPair ::
  first : Float
  second : Float
  deriving BEq

#guard Pair.mkPair 1.0 2.0 == { first := 1.0, second := 2.0 }
#check (Pair.first)
#check (Pair.second)

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

#guard Point.modifyBoth Float.floor floatPoint1 == { x := 1.0, y := -2.0 }
#guard Point.modifyBoth Float.floor floatPoint2 == { x := -1.0, y := -1.0 }
#guard floatPoint1.modifyBoth Float.floor == floatPoint1

-- exercises

-- Define a structure named RectangularPrism that contains the height, width, and depth of a rectangular prism, each as a Float.
structure RectangularPrism where
  height : Float
  width : Float
  depth : Float

-- Define a function named volume : RectangularPrism → Float that computes the volume of a rectangular prism.
def volume (p : RectangularPrism) : Float :=
  p.height * p.width * p.depth

#guard volume { height := 10.0, width := 20.0, depth := 30.0 } == 6000.0

-- Define a structure named Segment that represents a line segment by its endpoints, and define a function length : Segment → Float that computes the length of a line segment. Segment should have at most two fields.
structure Segment where
  start : Point
  finish : Point

def length (seg : Segment) : Float :=
  distance seg.start seg.finish

#guard distance floatPoint3 origin == 5.0

-- Which names are introduced by the declaration of RectangularPrism?
-- RectangularPrism.mk, RectangularPrism, RectangularPrism.height, RectangularPrism.width, and RectangularPrism.depth

-- Which names are introduced by the following declarations of Hamster and Book? What are their types?
structure Hamster where
  name : String
  fluffy : Bool

-- Type
#check Hamster

-- String → Bool → Hamster
#check (Hamster.mk)

-- Hamsster → String
#check (Hamster.name)

-- Hamster → Bool
#check (Hamster.fluffy)

structure Book where
  makeBook ::
  title : String
  author : String
  price : Float

-- Type
#check Book

-- makeBook :: String → String → String → Float → Book
#check (Book.makeBook)

-- Book → String
#check (Book.title)

-- Book → String
#check (Book.author)

-- Book → Float
#check (Book.price)
