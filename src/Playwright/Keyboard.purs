module Playwright.Keyboard where

import Prelude
import Playwright.Internal (effCall, affCall)
import Playwright.Data (Keyboard)
import Playwright.Options (KeyboardPressOptions)
import Effect.Aff (Aff)
import Control.Promise (toAffE)
import Untagged.Coercible (class Coercible, coerce)

type Key = String

down :: Keyboard -> Key -> Aff Unit
down kbd =
  affCall "down" (\_ -> down) kbd

insertText :: Keyboard -> String -> Aff Unit
insertText kbd =
  affCall "insertText" (\_ -> insertText) kbd

press
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> Key -> o -> Aff Unit
press kbd key opts =
  affCall "press" (\_ -> press) kbd key opts

type'
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> String -> o -> Aff Unit
type' kbd text opts =
  affCall "type" (\_ -> type') kbd text opts

up :: Keyboard -> Key -> Aff Unit
up kbd = affCall "up" (\_ -> up) kbd
