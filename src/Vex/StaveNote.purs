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
import Effect (Effect)
import Simple.JSON (writeImpl)
import Vex.Builder (BuildStep)
import Vex.VexFlowFFI (VexStaveNote)
import Vex.VexFlowFFI as FFI

note :: Clef -> Array Note -> Duration -> Effect VexStaveNote
note clef keys duration = FFI.newStaveNote (writeImpl {clef, keys, duration})

addAccidental :: forall s. Int -> Accidental -> BuildStep s s VexStaveNote
addAccidental n acc = traverse $ FFI.addAccidental n (writeImpl acc)

addArticulation :: forall s. Int -> Articulation -> BuildStep s s VexStaveNote
addArticulation n art = traverse $ FFI.addArticulation n (writeImpl art)

-- addAnnotation :: Annotation -> Free StaveNoteF Unit
-- addAnnotation ann = liftF (AddAnnotation ann unit)

addDot :: forall s. Int -> BuildStep s s VexStaveNote
addDot n = traverse $ FFI.addDot n

addDotToAll :: forall s. BuildStep s s VexStaveNote
addDotToAll = traverse FFI.addDotToAll
