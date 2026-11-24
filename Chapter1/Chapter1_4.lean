-- Structures

structure Point : Type where
    x : Float
    y : Float
  deriving BEq

def origin : Point := { x := 0.0, y := 0.0 }

#guard origin.x = 0.0
#guard origin.y = 0.0

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

def point1 : Point := { x := 1.5, y := 32 }
def point2 : Point := { x := -8, y := 0.2 }

#guard addPoints point1 origin == point1
#guard addPoints point1 point2 == { x := -6.5, y := 32.2 }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt ((p1.x - p2.x)^2.0 + (p1.y - p2.y)^2.0)

#guard distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 } = 5

structure Point3D : Type where
  x : Float
  y : Float
  z : Float

def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }

-- updating structures

def zeroX (p : Point) : Point :=
  { p with x := 0 }

#guard zeroX point1 == { x := 0.0, y := 32 }

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

#eval point1.modifyBoth Float.floor
#eval Point.modifyBoth Float.floor point2

-- exercises

structure RectangularPrism : Type where
  height : Float
  width : Float
  depth : Float

#check RectangularPrism
#check RectangularPrism.mk
#check RectangularPrism.height
#check RectangularPrism.width
#check RectangularPrism.depth

def prism1 : RectangularPrism := { height := 10.0, width := 20.0, depth := 30.0 }

def volume (prism : RectangularPrism) : Float :=
  prism.height * prism.width * prism.depth

#guard volume prism1 == 6000

structure Segment : Type where
  startPoint : Point
  endPoint : Point

def length (seg : Segment) : Float :=
  distance seg.startPoint seg.endPoint

structure Hamster where
  name : String
  fluffy : Bool

#check Hamster
#check Hamster.mk
#check Hamster.name
#check Hamster.fluffy

structure Book where
  makeBook ::
  title : String
  author : String
  price : Float

#check Book
#check Book.makeBook
#check Book.title
#check Book.author
#check Book.price



