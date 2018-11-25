module Vex.Voice where

import Prelude
import Prim.Row
import Type.Row
import Vex.Builder
import Vex.Types

import Control.Monad.Except (ExceptT(..))
import Data.Traversable (traverse)
import Effect (Effect)
import Simple.JSON (writeImpl)
import Vex.VexFlowFFI (VexStaveNote, VexVoice)
import Vex.VexFlowFFI as FFI

-- isComplete :: VexVoice -> Effect Boolean
-- isComplete = FFI.isComplete


newVoice :: Voice -> Effect (Builder () VexVoice)
newVoice voice = Builder <$> FFI.newVoice (writeImpl voice)

addTickable :: forall s. VexStaveNote -> BuildStep s s VexVoice
addTickable note = traverse (FFI.addTickable note)

addTickables :: forall s. Array VexStaveNote -> BuildStep s s VexVoice
addTickables notes = traverse (FFI.addTickables notes)

{-  To draw a voice, it must
    * be complete (that is, fills an entire bar)
    * have been provided context
    * have been provided a stave

    Unfortununatly completeness is not verified on the type level (though it might be possible to), and will throw a JS error if this predicate is violated. The other conditions are verified using the typerow in the `Builder`.
-}
drawVoice
  :: forall s
   . Builder ( HasContext + HasStave + s ) VexVoice 
  -> Effect Unit
drawVoice (Builder x) = FFI.drawVoice x