module Vex.Builder where

import Prelude

import Data.Traversable (class Foldable, class Traversable, foldlDefault, foldrDefault, sequenceDefault, traverse)
import Effect (Effect)
import Vex.Types

data ProvidedContext
data ProvidedStave
data Rendered

type HasContext r = ( hasContext :: ProvidedContext | r )
type HasStave r   = ( providedStave :: ProvidedStave | r )
type IsRendered r = ( rendered :: Rendered | r ) 

data Builder (s :: # Type) x = Builder x


class Buildable b x | b -> x where
  build :: b -> x

instance builderBuilder :: Buildable (Builder s x) x where
  build (Builder x) = x
else
instance builderIdentity :: Buildable a a where
  build  = identity

instance functorBuilder :: Functor (Builder s) where
  map f (Builder x) = Builder (f x)

instance foldableBuilder :: Foldable (Builder s) where
  foldr f z (Builder x) = f x z
  foldl f z (Builder x) = f z x
  foldMap f (Builder x) = f x

instance traversableBuilder :: Traversable (Builder s) where
  traverse f (Builder x) = Builder <$> f x
  sequence (Builder x) = Builder <$> x

type BuildStep s1 s2 x = Builder s1 x -> Effect (Builder s2 x)

infixl 4 bind as ..