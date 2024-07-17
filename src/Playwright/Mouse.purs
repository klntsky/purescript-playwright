module Playwright.Mouse where

import Effect.Aff (Aff)
import Playwright.Data (Mouse)
import Playwright.Internal (affCall)
import Playwright.Options (MouseClickOptions, MouseDblClickOptions, MouseMoveOptions, MouseUpDownOptions)
import Prelude (Unit)
import Untagged.Castable (class Castable)

click
  :: Mouse
  -> Int
  -> Int
  -> MouseClickOptions
  -> Aff Unit
click = affCall "click" \_ -> click

dblclick
  :: Mouse
  -> Int
  -> Int
  -> MouseDblClickOptions
  -> Aff Unit
dblclick = affCall "dblclick" \_ -> dblclick

down
  :: forall o
   . Castable o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
down = affCall "down" \_ -> down

move
  :: forall o
   . Castable o MouseMoveOptions
  => Mouse
  -> o
  -> Aff Unit
move = affCall "move" \_ -> move

up
  :: forall o
   . Castable o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
up = affCall "up" \_ -> up
