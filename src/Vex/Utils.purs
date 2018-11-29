module Vex.Utils (
  c, d, e, f, g, a, b,
  whole,        wholeRest,   
  half,         halfRest,        
  quarter,      quarterRest,     
  eighth,       eighthRest,      
  sixteenth,    sixteenthRest,   
  thirtySecond, thirtySecondRest,
  sixtyFourth,  sixtyFourthRest 
) where

import Data.String.Read
import Prelude
import Vex.Types

import Control.Monad.State (StateT(..))
import Data.Maybe (fromMaybe, maybe)
import Data.Tuple (Tuple(..))
import Partial.Unsafe (unsafeCrashWith)

note :: Pitch -> Accidental -> Int -> Note
note pitch accidental n = Note { pitch, accidental, octave: Octave n }

-- Easy constructors for notes
c = note C
d = note D
e = note E
f = note F
g = note G
a = note A
b = note B

-- r :: forall r. Show r => Read r => r -> String
-- r x = fromMaybe (unsafeCrashWith default) (read x)
--   where default = "Couldn't read value" <> show x <> "."

duration =
  { w: Duration Whole
  , h: Duration Half
  , q: Duration Quarter
  , e: Duration Eighth
  , x: Duration Sixteenth
  , t: Duration ThirtySecond
  , s: Duration SixtyForth
  }

whole            = duration.w NoteD
half             = duration.h NoteD
quarter          = duration.q NoteD
eighth           = duration.e NoteD
sixteenth        = duration.x NoteD
thirtySecond     = duration.t NoteD
sixtyFourth      = duration.s NoteD
wholeRest        = duration.w NoteD
halfRest         = duration.h NoteD
quarterRest      = duration.q NoteD
eighthRest       = duration.e NoteD
sixteenthRest    = duration.x NoteD
thirtySecondRest = duration.t NoteD
sixtyFourthRest  = duration.s NoteD

