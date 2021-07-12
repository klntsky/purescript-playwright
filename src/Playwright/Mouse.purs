module Playwright.Mouse where

import Effect.Aff
import Playwright.Data
import Playwright.Internal
import Playwright.Options
import Prelude
import Untagged.Castable (class Castable)
import Untagged.Union

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
  .  Castable o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
down = affCall "down" \_ -> down

move
  :: forall o
  .  Castable o MouseMoveOptions
  => Mouse
  -> o
  -> Aff Unit
move = affCall "move" \_ -> move

up
  :: forall o
  .  Castable o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
up = affCall "up" \_ -> up
