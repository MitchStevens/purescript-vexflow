module Main where

import Data.Rational
import Prelude
import Vex.Flow

import Effect (Effect)
import Effect.Class.Console (log)
import Vex.Types (Backend(..), Clef(..), Duration(..), DurationType(..), Renderer(..), Stave(..), TimeSignature(..))



main :: Effect Unit
main = step1

quarter = Duration (1 % 4) NoteD
eighth  = Duration (1 % 8) NoteD

step1 :: Effect Unit
step1 = onload $ do
  element <- getElement "step1"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx 

  drawStave stave


{-
step1 :: Effect Unit
step1 = onload $ do
  element <- getElement "step1"
  renderer <- execStateT
    (resize {width: 500.0, height: 500.0})
    <$> newRenderer (Renderer {element, backend: SVG})
  context <- getContext renderer

  stave <- execStateT
    (Stave {x: 10, y: 40, width: 400.0})
    do addClef Treble
       addTimeSignature (TimeSignature 4 4)
       setContext context
  
  drawStave stave

step2 :: Effect Unit
step2 = onload $ do
  element <- getElement "step2"
  renderer <- execStateT
    (resize {width: 500.0, height: 500.0})
    (Renderer {element, backend: SVG})
  context <- getContext renderer

  stave <- execStateT
    (Stave {x: 10, y: 40, width: 400.0})
    do addClef Treble
       addTimeSignature (TimeSignature 4 4)
       setContext context
  
  notes <- traverse execStateT
    [ note Treble [c Natural 4] quarter
    , note Treble [d Natural 4] quarter
    , note Treble [b Natural 4] (Duration (1 % 4) RestD)
    , note Treble [c Natural 4, e Natural 4, g Natural 4] quarter
    ]
  
  drawStave stave

-- test1 :: Effect Unit
-- test1 = do
--   element <- getElement "ode-to-joy"
--   render <- createRendererSVG element
--   ctx <- getContext render

--   stave <- build (new (Stave {x: 5, y: 5, width: 300.0}) $
--     do addClef Treble
--        addTimeSignature (TimeSignature 4 4)
--        setContext ctx)

--   notes <- (traverse build 
--     [ note Treble [e Natural 5] eighth
--     , note Treble [e Natural 5] eighth
--     , note Treble [f Natural 5] eighth
--     , note Treble [g Natural 5] eighth
--     , note Treble [g Natural 5] eighth
--     , note Treble [f Natural 5] eighth
--     , note Treble [e Natural 5] eighth
--     , note Treble [d Natural 5] eighth ])

--   formatAndDraw ctx stave notes
--   --drawStave stave
-}