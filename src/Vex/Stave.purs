module Vex.Stave where

import Data.Traversable
import Prelude
import Vex.Builder
import Vex.Types

import Effect (Effect)
import Simple.JSON (writeImpl)
import Vex.Builder (BuildStep)
import Vex.VexFlowFFI (VexStave)
import Vex.VexFlowFFI as FFI

newStave :: Stave -> Effect (Builder () VexStave)
newStave stave = Builder <$> FFI.newStave (writeImpl stave)

addClef :: forall s. Clef -> BuildStep s s VexStave
addClef = traverse <<< FFI.addClef <<< writeImpl

addKeySignature :: forall s. KeySignature -> BuildStep s s VexStave
addKeySignature = traverse <<< FFI.addKeySignature <<< writeImpl

addTimeSignature :: forall s. TimeSignature -> BuildStep s s VexStave
addTimeSignature = traverse <<< FFI.addTimeSignature <<< writeImpl

drawStave
  :: forall s
  . Builder ( HasContext s ) VexStave -> Effect Unit
drawStave (Builder stave) = FFI.drawStave stave