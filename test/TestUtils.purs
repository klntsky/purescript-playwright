module TestUtils
  ( assertForeignTrue
  , withBrowser
  , withBrowserPage
  , testClickEvent
  , cwd
  , isNull
  ) where

import Test.Unit.Assert as Assert
import Foreign (Foreign, readBoolean)
import Control.Monad.Except (runExcept)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Prelude (Unit, bind, discard, void, ($), (<>), (==))
import Playwright
import Control.Monad.Error.Class (withResource)

assertForeignTrue :: Foreign -> Aff Unit
assertForeignTrue value = do
  let
    eiBool = runExcept $ readBoolean value
  Assert.assert "Foreign value is boolean true" (eiBool == Right true)

withBrowser :: forall a. (Browser -> Aff a) -> Aff a
withBrowser = withResource acquire release
  where
  acquire = launch chromium {}
  release = close

withBrowserPage :: forall a. URL -> (Page -> Aff a) -> Aff a
withBrowserPage url action = do
  withBrowser
    \browser -> do
      let
        acquire = newPage browser { acceptDownloads: true }
        release = close
      withResource acquire release
        \page -> do
          void $ goto page url {}
          action page

testClickEvent :: String -> (Page -> Selector -> {} -> Aff Unit) -> Page -> Aff Unit
testClickEvent event action page = do
  void $ evaluate page ("setEventTester('" <> event <> "');")
  action page (Selector $ "#event-" <> event) {}
  result <- evaluate page $ "checkEventHappened('" <> event <> "');"
  assertForeignTrue result

foreign import isNull :: forall a. a -> Boolean

foreign import cwd :: String
