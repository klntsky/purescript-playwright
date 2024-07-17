module Test.Main where

import Control.Monad.Except (runExcept)
import Data.Either (isLeft)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Aff (launchAff_, try)
import Effect.Class (liftEffect)
import Effect.Console as Console
import Effect.Ref as Ref
import Foreign as Foreign
import Node.Encoding as Encoding
import Node.FS.Aff as FS
import Node.Stream as Stream
import Playwright (Selector(..), URL(..), chromium, click, close, dblclick, evaluate, exposeBinding, isClosed, launch, mainFrame, name, screenshot, textContent, url, version, waitForFunction, waitForSelector, waitForTimeout)
import Node.EventEmitter (on_)
import Playwright.ConsoleMessage as ConsoleMessage
import Playwright.Dialog as Dialog
import Playwright.Download as Download
import Playwright.Event (on)
import Playwright.Event as Event
import Prelude (Unit, bind, discard, pure, void, (#), ($), (/=), (<$>), (<<<), (<>), (=<<), (==))
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)
import TestUtils (cwd, isNull, testClickEvent, withBrowser, withBrowserPage)
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
          res <- try $ waitForSelector page (Selector "nonexistent") { timeout: Milliseconds 100.0 }
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
            { timeout: Milliseconds 5000.0, polling: 100 }
  suite "FFI" do
    test "exposeBinding" do
      withBrowserPage hello \page -> do
        ref <- liftEffect $ Ref.new Nothing
        frgnRef <- liftEffect $ Ref.new Nothing
        exposeBinding page "hi_ffi"
          ( \({ frame }) frgn -> do
              url <- liftEffect $ url frame
              liftEffect do
                Console.log "hi"
                Ref.write (Just frgn) frgnRef
                Ref.write (Just url) ref
          )
        void $ evaluate page "hi_ffi(12);"
        waitForTimeout page 100
        mbUrl <- liftEffect $ Ref.read ref
        mbForeign <- liftEffect $ Ref.read frgnRef
        Assert.equal (Just hello) mbUrl
        Assert.assert "exposeBinding is not able to accept an argument"
          $ pure (pure 12)
              == (runExcept <<< Foreign.readInt <$> mbForeign)
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
    test "download" do
      withBrowserPage hello
        \page -> do
          downloadRef <- liftEffect $ Ref.new Nothing
          liftEffect $ on Event.download page $ \download -> launchAff_ do
            fname <- liftEffect $ Download.suggestedFilename download
            Assert.equal "hello.txt" fname
            mbStream <- Download.createReadStream download
            failureStatus <- Download.failure download
            Assert.equal true (isNull failureStatus)
            case mbStream of
              Nothing -> Assert.assert "Unable to get stream" false
              Just stream -> do
                liftEffect $ Stream.setEncoding stream Encoding.UTF8
                liftEffect $ stream # on_ Stream.dataHStr \string -> do
                  Ref.write (Just string) downloadRef
          void $ evaluate page
            """
            {
                function download(filename, text) {
                  var element = document.createElement('a');
                  element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
                  element.setAttribute('download', filename);
                  document.body.appendChild(element);
                  element.click();
                  document.body.removeChild(element);
                }
                download("hello.txt","hiiii");
            }
            """
          waitForTimeout page 100
          downloadContent <- liftEffect $ Ref.read downloadRef
          Assert.equal (Just "hiiii") downloadContent
    test "dialog" do
      withBrowserPage hello
        \page -> do
          liftEffect $ on Event.dialog page $ \dialog -> launchAff_ do
            defaultValue <- liftEffect $ Dialog.defaultValue dialog
            Assert.equal "hello" defaultValue
            message <- liftEffect $ Dialog.message dialog
            Assert.equal "hi" message
            Dialog.dismiss dialog
          void $ evaluate page
            """
            prompt("hi", "hello");
            """
