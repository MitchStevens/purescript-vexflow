module Vex.Formatter where

import Prelude
import Vex.Types

import Effect (Effect)
import Vex.Builder (class Buildable, build)
import Vex.VexFlowFFI (VexContext, VexFormatter, VexStave, VexStaveNote, VexVoice)
import Vex.VexFlowFFI as FFI

newFormatter :: Effect VexFormatter
newFormatter = FFI.newFormatter

format 
  :: forall vexVoice
   . Buildable vexVoice VexVoice
   => Array vexVoice -> Number -> VexFormatter -> Effect VexFormatter
format voices = FFI.format (map build voices)

--formatToStave TODO::

formatAndDraw
  :: forall vexStave
   . Buildable vexStave VexStave
  => VexContext -> vexStave -> Array VexStaveNote -> Effect Unit
formatAndDraw ctx stave notes =
  FFI.formatAndDraw ctx (build stave) notes


joinVoices
  :: forall vexVoice
   . Buildable vexVoice VexVoice
  => Array vexVoice -> VexFormatter -> Effect VexFormatter
joinVoices voices = FFI.joinVoices (map build voices)