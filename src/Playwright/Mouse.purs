module Playwright.Mouse where

import Effect.Aff
import Playwright.Data
import Playwright.Internal
import Playwright.Options
import Prelude
import Untagged.Coercible (class Coercible)
import Untagged.Union

click
  :: Mouse
  -> Int
  -> Int
  -> MouseClickOptions
  -> Aff Unit
click m x y o = affCall "click" typeInfo m x y o
  where typeInfo _ = click

dblclick
  :: Mouse
  -> Int
  -> Int
  -> MouseDblClickOptions
  -> Aff Unit
dblclick m x y o = affCall "dblclick" typeInfo m x y o
  where typeInfo _ = dblclick

down
  :: forall o
  .  Coercible o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
down m o = affCall "down" typeInfo m o
  where typeInfo _ = down

move
  :: forall o
  .  Coercible o MouseMoveOptions
  => Mouse
  -> o
  -> Aff Unit
move m o = affCall "move" typeInfo m o
  where typeInfo _ = move

up
  :: forall o
  .  Coercible o MouseUpDownOptions
  => Mouse
  -> o
  -> Aff Unit
up m o = affCall "up" typeInfo m o
  where typeInfo _ = up
