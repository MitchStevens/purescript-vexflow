module Vex.Beam where

import Prelude
import Vex.Builder
import Effect (Effect)
import Vex.VexFlowFFI (VexStaveNote, VexBeam)
import Vex.VexFlowFFI as FFI

newBeam :: Array VexStaveNote -> Effect (Builder () VexBeam)
newBeam notes = Builder <$> FFI.newBeam notes

generateBeams :: Array VexStaveNote -> Effect (Array (Builder () VexBeam))
generateBeams notes = (map<<<map) Builder (FFI.generateBeams notes)

drawBeam
  :: forall s
  . Builder ( HasContext s ) VexBeam -> Effect Unit
drawBeam (Builder beam) = FFI.drawBeam beam