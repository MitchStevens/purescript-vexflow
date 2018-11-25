module Vex.Formatter where

import Prelude
import Vex.Types

import Effect (Effect)
import Vex.VexFlowFFI (VexContext, VexFormatter, VexStave, VexStaveNote, VexVoice)
import Vex.VexFlowFFI as FFI

newFormatter :: Effect VexFormatter
newFormatter = FFI.newFormatter

format :: Array VexVoice -> Number -> VexFormatter -> Effect VexFormatter
format = FFI.format

--formatToStave TODO::

formatAndDraw :: VexContext -> VexStave -> Array VexStaveNote -> Effect Unit
formatAndDraw = FFI.formatAndDraw


joinVoices :: Array VexVoice -> VexFormatter -> Effect VexFormatter
joinVoices = FFI.joinVoices