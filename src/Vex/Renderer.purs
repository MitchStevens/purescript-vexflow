module Vex.Renderer where

import Prelude
import Vex.Types

import Data.Traversable (traverse)
import Effect (Effect)
import Simple.JSON (writeImpl)
import Vex.Builder (BuildStep, Builder(..), HasContext)
import Vex.VexFlowFFI (VexRenderer)
import Vex.VexFlowFFI as FFI

newRenderer :: Renderer -> Effect (Builder (HasContext ()) VexRenderer)
newRenderer (Renderer renderer) = Builder <$> case renderer.backend of
  SVG    -> FFI.createRendererSVG renderer.element
  Canvas -> FFI.createRendererCanvas renderer.element

resize :: forall s. Dimensions -> BuildStep s s VexRenderer
resize dims = traverse $ FFI.resize (writeImpl dims)