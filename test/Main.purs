module Test.Main where

import Control.Monad.Error.Class (try)
import Data.Either (isLeft)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Ref as Ref
import Node.FS.Aff as FS
import Playwright
import Playwright.ConsoleMessage as ConsoleMessage
import Playwright.Event as Event
import Playwright.Event (on)
import Prelude (Unit, bind, discard, void, ($), (/=), (<>), (=<<))
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)
import TestUtils (cwd, testClickEvent, withBrowser, withBrowserPage)
import Untagged.Union (fromOneOf)

static :: String -> URL
static file =
  URL $ "file://" <> cwd <> "/test/static/" <> file

main :: Effect Unit
main = runTest do
  let
   hello = static "hello.html"
   index = static "index.html"
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
    test "click" do
      withBrowserPage index $ testClickEvent "click" click
    test "dblclick" do
      withBrowserPage index $ testClickEvent "dblclick" dblclick
    test "waitForSelector" do
      withBrowserPage hello
        \page -> do
          void $ waitForSelector page (Selector "body") {}
          res <- try $ waitForSelector page (Selector "nonexistent") { timeout: 100 }
          Assert.assert "waitForSelector fails when no element" $
            isLeft res
    test "waitForFunction" do
      withBrowserPage hello
        \page -> do
          void $ evaluate page
            "setTimeout(() => document.body.textContent += 'uniqstring', 1)"
          void $ waitForFunction
            page
            "document.body.textContent.includes('uniqstring')"
            { timeout: 5000, polling: 100 }
  suite "events" do
    test "console" do
      withBrowserPage hello
        \page -> do
          messageRef <- liftEffect $ Ref.new Nothing
          liftEffect $ on Event.console page $ \cslMessage -> do
            realMessage <- ConsoleMessage.text cslMessage
            Ref.write (Just realMessage) messageRef
          void $ evaluate page
            """
            console.log('hi');
            """
          realMessage <- liftEffect $ Ref.read messageRef
          Assert.equal (Just "hi") realMessage
    test "console: ConsoleMessageType" do
      withBrowserPage hello
        \page -> do
          typeRef <- liftEffect $ Ref.new Nothing
          liftEffect $ on Event.console page $ \cslMessage -> do
            realType <- ConsoleMessage.type' cslMessage
            Ref.write (Just realType) typeRef
          void $ evaluate page
            """
            console.debug('hi');
            """
          realType <- liftEffect $ Ref.read typeRef
          Assert.equal (Just ConsoleMessage.Debug) realType
