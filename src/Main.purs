module Main where

import Data.Rational
import Prelude
import Vex.Flow

import Data.Traversable (for_, sequence, traverse)
import Effect (Effect)
import Effect.Class.Console (log)
import Test as Test
import Vex.Utils (a, b, c, d, e, g)



main :: Effect Unit
main = Test.allSteps