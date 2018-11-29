module Vex.StaveNote (
  note,
  addAccidental,
  addArticulation,
  -- addAnnotation,
  addDot,
  addDotToAll
) where

import Prelude
import Vex.Types

import Data.Traversable (traverse)
import Data.Typelevel.Num (class Nat, class Pos)
import Data.Vec (Vec)
import Effect (Effect)
import Simple.JSON (writeImpl)
import Vex.Builder (BuildStep)
import Vex.VexFlowFFI (VexStaveNote)
import Vex.VexFlowFFI as FFI

note :: Clef -> Array Note -> Duration -> Effect VexStaveNote
note clef keys duration = FFI.newStaveNote (writeImpl {clef, keys, duration})

addAccidental :: Int -> Accidental -> VexStaveNote -> Effect VexStaveNote
addAccidental n acc = FFI.addAccidental n (writeImpl acc)

addArticulation :: Int -> Articulation -> VexStaveNote -> Effect VexStaveNote
addArticulation n art = FFI.addArticulation n (writeImpl art)

-- addAnnotation :: Annotation -> Free StaveNoteF Unit
-- addAnnotation ann = liftF (AddAnnotation ann unit)

addDot :: Int -> VexStaveNote -> Effect VexStaveNote
addDot n = FFI.addDot n

addDotToAll :: VexStaveNote -> Effect VexStaveNote
addDotToAll = FFI.addDotToAll
