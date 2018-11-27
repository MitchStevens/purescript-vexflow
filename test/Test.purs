module Test where

import Data.Rational
import Prelude
import Vex.Flow

import Data.Traversable (for_, sequence, traverse)
import Effect (Effect)
import Effect.Class.Console (log)
import Vex.Utils (a, b, c, d, e, g)



main :: Effect Unit
main = allSteps

whole        = Duration (1 % 1)  NoteD
half         = Duration (1 % 2)  NoteD
quarter      = Duration (1 % 4)  NoteD
eighth       = Duration (1 % 8)  NoteD
sixteenth    = Duration (1 % 16) NoteD
thirtySecond = Duration (1 % 32) NoteD

allSteps :: Effect Unit
allSteps =
  step1 *> step2a *> step2b *> step3a *> step3b *> step4a *> step4b

step1 :: Effect Unit
step1 = do
  element <- getElement "step1"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx 

  drawStave stave


step2a :: Effect Unit
step2a = do
  element <- getElement "step2a"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes <- sequence
    [ note Treble [c Natural 4] quarter
    , note Treble [d Natural 4] quarter
    , note Treble [b Natural 4] (Duration (1 % 4) RestD)
    , note Treble [c Natural 4, e Natural 4, g Natural 4] quarter
    ]
  
  voice <- newVoice (Voice (TimeSignature 4 4))
    .. addTickables notes
    .. setContext ctx
    .. setStave stave

  formatter <- newFormatter
    .. joinVoices [build voice]
    .. format [build voice] 400.0

  drawVoice voice


step2b :: Effect Unit
step2b = do
  element <- getElement "step2b"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes1 <- sequence
    [ note Treble [c Natural 5] quarter
    , note Treble [d Natural 4] quarter
    , note Treble [b Natural 4] (Duration (1 % 4) RestD)
    , note Treble [c Natural 4, e Natural 4, g Natural 4] quarter
    ]

  notes2 <- sequence
    [ note Treble [c Natural 4] whole ]

  (voices :: Array (Builder () VexVoice)) <- sequence
    [ newVoice (Voice (TimeSignature 4 4))
        .. addTickables notes1 
    , newVoice (Voice (TimeSignature 4 4))
        .. addTickables notes2
    ]

  formatter <- newFormatter
    .. joinVoices voices
    .. format voices 400.0

  for_ voices $ \v ->
    setContext ctx v
      .. setStave stave
      .. drawVoice

step3a :: Effect Unit
step3a = do
  element <- getElement "step3a"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes <- sequence
    [ note Treble [e DoubleSharp 5] (Dotted eighth NoteD)
      .. addAccidental 0 DoubleSharp .. addDotToAll
    , note Treble [e Flat 5] sixteenth
      .. addAccidental 0 Flat
    , note Treble [d Natural 5, e Flat 4] half
      .. addDot 0
    , note Treble [c Natural 5, e Flat 5, g Sharp 5] quarter
      .. addAccidental 1 Flat
      .. addAccidental 2 Sharp
      .. addDotToAll
    ]

  formatAndDraw ctx stave notes

step3b :: Effect Unit
step3b = do
  element <- getElement "step3b"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes <- sequence
    [ note Treble [ g Natural 4
                  , b Natural 4
                  , c Flat 5
                  , e Natural 5
                  , g Sharp 5
                  , b Natural 5] half
        .. addAccidental 0 DoubleFlat
        .. addAccidental 1 Flat
        .. addAccidental 2 Sharp
        .. addAccidental 3 Natural
        .. addAccidental 4 Flat
        .. addAccidental 5 DoubleSharp
    , note Treble [c Natural 4] half
    ]

  formatAndDraw ctx stave notes

step4a :: Effect Unit
step4a = do
  element <- getElement "step3b"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes <- sequence
    [ note Treble [e DoubleSharp 5] (Dotted eighth NoteD)
      .. addAccidental 0 DoubleSharp
      .. addDotToAll
    , note Treble [b Natural 4] sixteenth
      .. addAccidental 0 Flat
    ]

  notes2 <- sequence
    [ note Treble [c Natural 4] eighth
    , note Treble [d Natural 4] sixteenth
    , note Treble [e Flat 4] sixteenth
      .. addAccidental 0 Flat
    ]
  
  notes3 <- sequence
    [ note Treble [d Natural 4] sixteenth
    , note Treble [e Sharp 4] sixteenth
      .. addAccidental 0 Sharp
    , note Treble [g Natural 4] thirtySecond
    , note Treble [a Natural 4] thirtySecond
    , note Treble [g Natural 4] sixteenth
    ]
  
  notes4 <- sequence
    [ note Treble [d Natural 4] quarter ]

  beams <- sequence
    [ newBeam notes
    , newBeam notes2
    , newBeam notes3
    ]
  
  let allNotes = notes <> notes2 <> notes3 <> notes4

  formatAndDraw ctx stave allNotes

  for_ beams $ \b ->
    setContext ctx b .. drawBeam

step4b :: Effect Unit
step4b = do
  element <- getElement "step3b"
  renderer <- newRenderer (Renderer {element, backend: SVG})
    .. resize { width: 500.0, height: 500.0 }
  ctx <- getContext renderer

  stave <- newStave (Stave { x: 10, y: 40, width: 400.0 })
    .. addClef Treble
    .. addTimeSignature (TimeSignature 4 4)
    .. setContext ctx

  drawStave stave

  notes <- sequence
    [ note Treble [e DoubleSharp 5] (Dotted eighth NoteD)
      .. addAccidental 0 DoubleSharp
      .. addDotToAll
    , note Treble [b Natural 4] sixteenth
      .. addAccidental 0 Flat
    , note Treble [c Natural 4] eighth
    , note Treble [d Natural 4] sixteenth
    , note Treble [e Flat 4] sixteenth
      .. addAccidental 0 Flat
    , note Treble [d Natural 4] sixteenth
    , note Treble [e Sharp 4] sixteenth
      .. addAccidental 0 Sharp
    , note Treble [g Natural 4] thirtySecond
    , note Treble [a Natural 4] thirtySecond
    , note Treble [g Natural 4] sixteenth
    , note Treble [d Natural 4] quarter ]
  
  beams <- generateBeams notes
  formatAndDraw ctx stave notes
  for_ beams $ \b ->
    setContext ctx b .. drawBeam