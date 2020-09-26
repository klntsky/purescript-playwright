module Test.Main where

import Prelude
import Playwright
import Effect (Effect)
import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Untagged.Union (fromOneOf)
import Test.Unit.Assert as Assert
import Data.Maybe (Maybe(..))
import Node.FS.Aff as FS
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Control.Monad.Error.Class (withResource)

static :: String -> URL
static file =
  URL $ "file://" <> cwd <> "/test/static/" <> file

main :: Effect Unit
main = runTest do
  let hello = static "hello.html"
  suite "browser" do
    test "launch, close" do
      browser <- launch chromium {}
      close browser
    test "close/isClosed" do
      withBrowserPage hello
        \page -> do
          Assert.assertFalse "new page is closed" =<<
            liftEffect (isClosed page)
          close page
          Assert.assert "page is not closed" =<< liftEffect (isClosed page)
    test "version" do
      withBrowser
        \browser -> do
          v <- liftEffect $ version browser
          Assert.assert "version is empty" (v /= "")
    test "url" do
      withBrowserPage hello
        \page -> do
          Assert.equal hello =<< liftEffect (url page)
    test "screenshot" do
      withBrowserPage hello
        \page -> do
          void $ screenshot page { path: "screenshot.png" }
          FS.unlink "screenshot.png"
    test "textContent" do
      withBrowserPage hello
        \page -> do
          text <- textContent page (Selector "body")
          Assert.equal (Just "hello\n") (fromOneOf text)
    test "mainFrame" do
      withBrowserPage hello
        \page -> do
          frame <- liftEffect $ mainFrame page
          frameName <- liftEffect $ name frame
          Assert.equal "" frameName

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

foreign import cwd :: String
