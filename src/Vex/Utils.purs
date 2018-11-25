module Vex.Utils (
  c, d, e, f, g, a, b
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