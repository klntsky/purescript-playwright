module TestUtils where

import Test.Unit.Assert as Assert
import Foreign
import Control.Monad.Except
import Data.Either
import Effect.Aff
import Prelude
import Playwright
import Control.Monad.Error.Class (withResource)

assertForeignTrue :: Foreign -> Aff Unit
assertForeignTrue value = do
  let
    eiBool = runExcept $ readBoolean value
  Assert.assert "Foreign value is boolean true" (eiBool == Right true)

withBrowser :: forall a. (Browser -> Aff a) -> Aff a
withBrowser action = withResource acquire release action
  where
    acquire = launch chromium {}
    release = close

withBrowserPage :: forall a. URL -> (Page -> Aff a) -> Aff a
withBrowserPage url action = do
  withBrowser
    \browser -> do
      page <- newPage browser {}
      void $ goto page url {}
      action page

testClickEvent :: String -> (Page -> Selector -> {} -> Aff Unit) -> Page -> Aff Unit
testClickEvent event action page = do
  void $ evaluate page ("setEventTester('" <> event <> "');")
  action page (Selector $ "#event-" <> event) {}
  result <- evaluate page $ "checkEventHappened('" <> event <> "');"
  assertForeignTrue result

foreign import cwd :: String
