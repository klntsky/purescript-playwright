module Playwright.Keyboard where

import Prelude
import Playwright.Internal (effCall)
import Playwright.Data (Keyboard)
import Playwright.Options (KeyboardPressOptions)
import Effect.Aff (Aff)
import Control.Promise (toAffE)
import Untagged.Coercible (class Coercible, coerce)

type Key = String

down :: Keyboard -> Key -> Aff Unit
down kbd =
  effCall "down" (\_ -> down) kbd >>> toAffE

insertText :: Keyboard -> String -> Aff Unit
insertText kbd =
  effCall "insertText" (\_ -> insertText) kbd >>> toAffE

press
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> Key -> o -> Aff Unit
press kbd key opts =
  toAffE $ effCall "press" typeInfo kbd key
    (coerce opts :: KeyboardPressOptions)
  where
    typeInfo _ = press :: Keyboard -> Key -> o -> Aff Unit

type'
  :: forall o
  .  Coercible o KeyboardPressOptions
  => Keyboard -> String -> o -> Aff Unit
type' kbd text opts =
  toAffE $ effCall "type" typeInfo kbd text
    (coerce opts :: KeyboardPressOptions)
  where
    typeInfo _ = type' :: Keyboard -> String -> o -> Aff Unit

up :: Keyboard -> Key -> Aff Unit
up kbd = effCall "up" (\_ -> up) kbd >>> toAffE
