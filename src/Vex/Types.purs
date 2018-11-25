module Vex.Types 
-- (
--   Pitch(..),
--   Accidental(..),
--   Octave(..),
--   Note(..),
--   Clef(..),
--   Articulation(..),
--   TimeSignature(..),
--   KeySignature(..),
--   Annotation(..),
--   Quality(..),
--   Duration(..),
--     DurationType(..),
--     Irregular(..),
--   Stave,
--     StaveC(..),
--     StaveF(..),
--   StaveNote,
--     StaveNoteC(..),
--     StaveNoteF(..),
--   Voice,
--     VoiceC(..),
--     VoiceF(..)
-- )
where

import Data.Maybe
import Foreign
import Prelude
import Simple.JSON
import Data.Rational (Rational, denominator, (%))
import Effect.Console (log)
import Partial.Unsafe (unsafeCrashWith)

foreign import data HTMLElement   :: Type

data Pitch = C | D | E | F | G | A | B
instance showPitch :: Show Pitch where
  show = case _ of
    C -> "C"
    D -> "D"
    E -> "E"
    F -> "F"
    G -> "G"
    A -> "A"
    B -> "B"
instance writePitch :: WriteForeign Pitch where
  writeImpl = writeImpl <<< show


data Accidental = DoubleFlat | Flat | Natural | Sharp | DoubleSharp
instance showAccidental :: Show Accidental where
  show = case _ of
    DoubleFlat -> "bb"
    Flat -> "b"
    Natural -> ""
    Sharp -> "#"
    DoubleSharp -> "##"
instance writeAccidental :: WriteForeign Accidental where
  writeImpl = writeImpl <<< show


data Octave = Octave Int
instance showOctave :: Show Octave where
  show (Octave n) = show n
instance writeOctave :: WriteForeign Octave where
  writeImpl = writeImpl <<< show


newtype Note = Note
  { pitch :: Pitch
  , accidental :: Accidental
  , octave :: Octave }
instance showNote :: Show Note where
  show (Note note) =
    show note.pitch <> show note.accidental <> "/" <> show note.octave
instance writeNote :: WriteForeign Note where
  writeImpl = writeImpl <<< show

data Clef 
  = Treble 
  | Bass 
  | Tenor 
  | Alto 
  | Soprano 
  | Percussion 
  | MezzoSoprano 
  | BaritoneC 
  | BaritoneF 
  | SubBass 
  | French
instance showClef :: Show Clef where
  show = case _ of
    Treble       -> "treble"
    Bass         -> "bass"
    Tenor        -> "tenor"
    Alto         -> "alto"
    Soprano      -> "soprano"
    Percussion   -> "percussion"
    MezzoSoprano -> "mezzo-soprano"
    BaritoneC    -> "baritone-c"
    BaritoneF    -> "baritone-f"
    SubBass      -> "sub-base"
    French       -> "french"
instance writeClef :: WriteForeign Clef where
  writeImpl = writeImpl <<< show

data Articulation
  = AccentAbove
  | AccentBelow
  | TenutoAbove
  | TenutoBelow
  | StaccatoAbove
  | StaccatoBelow
  | StaccatissimoAbove
  | MarcatoAbove
instance writeArticulation :: WriteForeign Articulation where
  writeImpl _ = writeImpl "articulation"
  -- write = case _ of
  --   AccentAbove -> 
  --   AccentBelow
  --   TenutoAbove
  --   TenutoBelow
  --   StaccatoAbove
  --   StaccatoBelow
  --   StaccatissimoAbove
  --   MarcatoAbove

data Annotation = Annotation Void

data TimeSignature = TimeSignature Int Int
instance showTimeSignature :: Show TimeSignature where
  show (TimeSignature a b) = show a <> "/" <> show b
instance writeTimeSignature :: WriteForeign TimeSignature where
  writeImpl = writeImpl <<< show

data Quality = Major | Minor
instance showQuality :: Show Quality where
  show = case _ of
    Major -> ""
    Minor -> "m"
instance writeQuality :: WriteForeign Quality where
  writeImpl = writeImpl <<< show

data KeySignature = KeySignature Pitch Accidental Quality
instance showKeySignature :: Show KeySignature where
  show (KeySignature pitch accidental quality) =
    show pitch <> show accidental <> show quality
-- instance readKeySignature :: Read KeySignature where
--   read = case _ of
--     "C"   -> Just $ KeySignature C Natural Major
--     "Am"  -> Just $ KeySignature A Natural Minor
--     "F"   -> Just $ KeySignature F Natural Major
--     "Dm"  -> Just $ KeySignature D Natural Minor
--     "Bb"  -> KeySignature acc: Just FlatK,  num: 2 }
--     "Gm"  -> KeySignature acc: Just FlatK,  num: 2 }
--     "Eb"  -> KeySignature acc: Just FlatK,  num: 3 }
--     "Cm"  -> KeySignature acc: Just FlatK,  num: 3 }
--     "Ab"  -> KeySignature acc: Just FlatK,  num: 4 }
--     "Fm"  -> KeySignature acc: Just FlatK,  num: 4 }
--     "Db"  -> KeySignature acc: Just FlatK,  num: 5 }
--     "Bbm" -> KeySignature acc: Just FlatK,  num: 5 }
--     "Gb"  -> KeySignature acc: Just FlatK,  num: 6 }
--     "Ebm" -> KeySignature acc: Just FlatK,  num: 6 }
--     "Cb"  -> { acc: Just FlatK,  num: 7 }
--     "Abm" -> { acc: Just FlatK,  num: 7 }
--     "G"   -> { acc: Just SharpK, num: 1 }
--     "Em"  -> { acc: Just SharpK, num: 1 }
--     "D"   -> { acc: Just SharpK, num: 2 }
--     "Bm"  -> { acc: Just SharpK, num: 2 }
--     "A"   -> { acc: Just SharpK, num: 3 }
--     "Fsm" -> { acc: Just SharpK, num: 3 }
--     "E"   -> { acc: Just SharpK, num: 4 }
--     "Csm" -> { acc: Just SharpK, num: 4 }
--     "B"   -> { acc: Just SharpK, num: 5 }
--     "Gsm" -> { acc: Just SharpK, num: 5 }
--     "Fs"  -> { acc: Just SharpK, num: 6 }
--     "Dsm" -> { acc: Just SharpK, num: 6 }
--     "Cs"  -> { acc: Just SharpK, num: 7 }
--     "Asm" -> { acc: Just SharpK, num: 7 }
--     _ -> Nothing
instance writeKeySignature :: WriteForeign KeySignature where
  writeImpl = writeImpl <<< show

newtype Tempo = Tempo Int

data DurationType = NoteD | RestD
instance showDurationType :: Show DurationType where
  show = case _ of
    NoteD -> ""
    RestD -> "r"

data Duration
  = Dotted Duration DurationType
  | Tuplet Irregular DurationType
  | Duration Rational DurationType
instance showDuration :: Show Duration where
  show = case _ of
    Dotted duration dtype -> show duration <> show dtype
    Tuplet irregular dtype -> show irregular <> show dtype
    Duration regular dtype -> show regular <> show dtype
instance writeDuration :: WriteForeign Duration where
  writeImpl = writeImpl <<< show

data Regular = Whole | Half | Quarter | Eighth | Sixteenth | ThirtySecond | SixtyForth
instance showRegular :: Show Regular where
  show  = case _  of
    Whole        -> "1"
    Half         -> "2"
    Quarter      -> "4"
    Eighth       -> "8"
    Sixteenth    -> "16"
    ThirtySecond -> "32"
    SixtyForth   -> "64"

data Irregular = Three | Five | Six | Seven
instance showIrregular :: Show Irregular where
  show _ = "crazy time"--case _ of
    --Three -> ""

data Backend = SVG | Canvas

type Dimensions = { width :: Number, height :: Number }


--Voice Types
data Voice = Voice TimeSignature
instance writeVoice :: WriteForeign Voice where
  writeImpl (Voice timeSignature) = writeImpl timeSignature


--StaveNote Types
data StaveNote = StaveNote
  { clef :: Clef
  , keys :: Array Note
  , duration :: Duration }
instance writeStaveNote :: WriteForeign StaveNote where
  writeImpl (StaveNote note) = writeImpl note


--Stave Types
data Stave = Stave
  { x :: Int
  , y :: Int
  , width :: Number }
instance writeStave :: WriteForeign Stave where
  writeImpl (Stave stave) = writeImpl stave


--Renderer Types
data Renderer = Renderer
  { element :: HTMLElement
  , backend :: Backend }