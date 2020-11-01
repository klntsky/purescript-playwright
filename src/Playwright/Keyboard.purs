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
down =
  affCall "down" \_ -> down

insertText :: Keyboard -> String -> Aff Unit
insertText =
  affCall "insertText" \_ -> insertText

press
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> Key -> o -> Aff Unit
press =
  affCall "press" \_ -> press

type'
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> String -> o -> Aff Unit
type' =
  affCall "type" \_ -> type'

up :: Keyboard -> Key -> Aff Unit
up = affCall "up" \_ -> up
