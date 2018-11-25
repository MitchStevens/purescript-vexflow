module Vex.VexFlowFFI 
--(
--   onload,
--   getElement,
--   createRendererSVG,
--   createRendererCanvas,
--   resize,
--   getContext,
--   formatAndDraw,

--   newStave,
--   addClef,
--   addKeySignature,
--   addTimeSignature,
--   setContextStave,
--   drawStave,

--   newStaveNote,
--   addAccidental,
--   addArticulation,
--   --addAnnotation,
--   addDot,
--   addDotToAll,

--   newVoice,
--   addTickable,
--   addTickables,
--   setContextVoice,
--   setStave,
--   drawVoice
-- ) 
where

import Prim.Row
import Effect
import Foreign
import Prelude
import Simple.JSON
import Vex.Types
import Vex.Builder

import Control.Monad.State (StateT(..))
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..))
import Effect.Console (log)


-- Abstract data types for dealing with JS objects
foreign import data VexContext    :: Type
foreign import data VexFormatter  :: Type
foreign import data VexRenderer   :: Type
foreign import data VexVoice      :: Type
foreign import data VexStaveNote  :: Type
foreign import data VexStave :: Type


--Boilerplate functions
foreign import onload :: Effect Unit -> Effect Unit

foreign import getElement :: String -> Effect HTMLElement

foreign import createRendererSVG :: HTMLElement -> Effect VexRenderer

foreign import createRendererCanvas :: HTMLElement -> Effect VexRenderer

foreign import resize :: Foreign -> VexRenderer -> Effect VexRenderer

foreign import getContextRenderer :: VexRenderer -> Effect VexContext


--Formatter functions#
foreign import newFormatter
  :: Effect VexFormatter

foreign import format
  :: Array VexVoice -> Number -> VexFormatter -> Effect VexFormatter

-- foreign import formatToStave
--   :: Array VexVoice -> VexStave -> VexFormatter -> Effect VexFormatter

foreign import formatAndDraw
  :: VexContext -> VexStave -> Array VexStaveNote -> Effect Unit

foreign import joinVoices
  :: Array VexVoice -> VexFormatter -> Effect VexFormatter


--Stave functions
foreign import newStave
  :: Foreign -> Effect VexStave

foreign import addClef
  :: Foreign -> VexStave -> Effect VexStave

foreign import addKeySignature
  :: Foreign -> VexStave -> Effect VexStave

foreign import addTimeSignature
  :: Foreign -> VexStave -> Effect VexStave

foreign import getContextStave
  :: VexStave -> Effect VexContext

foreign import setContextStave
  :: VexContext -> VexStave -> Effect VexStave

foreign import drawStave
  :: VexStave -> Effect Unit


--StaveNote functions
foreign import newStaveNote
  :: Foreign -> Effect VexStaveNote

foreign import addAccidental
  :: Int -> Foreign -> VexStaveNote -> Effect VexStaveNote

foreign import addArticulation
  :: Int -> Foreign -> VexStaveNote -> Effect VexStaveNote

-- foreign import addAnnotation
--   :: forall annotation
--    . AswriteImpl Annotation annotation
--   => Int -> annotation -> VexStaveNote -> Effect VexStaveNote

foreign import addDot :: Int -> VexStaveNote -> Effect VexStaveNote

foreign import addDotToAll :: VexStaveNote -> Effect VexStaveNote


--Voice function
foreign import newVoice
  :: Foreign -> Effect VexVoice

foreign import addTickable
  :: VexStaveNote -> VexVoice -> Effect VexVoice

foreign import addTickables
  :: Array VexStaveNote -> VexVoice -> Effect VexVoice

foreign import getContextVoice
 :: VexVoice -> Effect VexContext

foreign import setContextVoice
  :: VexContext -> VexVoice -> Effect VexVoice

foreign import getStaveVoice
  :: VexVoice -> Effect VexStave

foreign import setStaveVoice
  :: VexStave -> VexVoice -> Effect VexVoice

foreign import drawVoice
  :: VexVoice -> Effect Unit


class GetContext v where
  getContext
    :: forall s 
     . Builder (HasContext s) v -> Effect VexContext

class SetContext v where
  setContext
    :: forall s1 s2
     . Nub (HasContext s1) s2
     => VexContext -> BuildStep s1 s2 v

class GetStave v where
  getStave
    :: forall s
     . Builder (HasStave s) v -> Effect VexStave

class SetStave v where
  setStave
    :: forall s1 s2
     . Nub (HasStave s1) s2
     => VexStave -> BuildStep s1 s2 v

--Instances for vextypes
instance getContextVexVoice :: GetContext VexVoice where
  getContext = getContextVoice <<< build
instance setContextVexVoice :: SetContext VexVoice where
  setContext ctx voice = Builder <$> setContextVoice ctx (build voice)
instance getStaveVexVoice :: GetStave VexVoice where
  getStave = getStaveVoice <<< build
instance setStaveVexVoice :: SetStave VexVoice where
  setStave stave voice = Builder <$> setStaveVoice stave (build voice)

instance getContextVexStave :: GetContext VexStave where
  getContext = getContextStave <<< build
instance setContextVexStave :: SetContext VexStave where
  setContext ctx stave = Builder <$> setContextStave ctx (build stave)

instance getContextVexRenderer :: GetContext VexRenderer where
  getContext = getContextRenderer <<< build