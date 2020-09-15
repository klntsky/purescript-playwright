module Playwright.Keyboard where

import Prelude
import Playwright.Internal (effCall)
import Playwright.Data (Keyboard)
import Playwright.Options (KeyboardPressOptions)
import Effect.Aff (Aff)
import Control.Promise (toAffE)

type Key = String

down :: Keyboard -> Key -> Aff Unit
down kbd =
  effCall "down" (\_ -> down) kbd >>> toAffE

insertText :: Keyboard -> String -> Aff Unit
insertText kbd =
  effCall "insertText" (\_ -> insertText) kbd >>> toAffE

press :: Keyboard -> Key -> KeyboardPressOptions -> Aff Unit
press kbd key =
  effCall "press" (\_ -> press) kbd key >>> toAffE

type' :: Keyboard -> String -> KeyboardPressOptions -> Aff Unit
type' kbd text =
  effCall "type" (\_ -> type') kbd text >>> toAffE

up :: Keyboard -> Key -> Aff Unit
up kbd =
  effCall "up" (\_ -> up) kbd >>> toAffE
