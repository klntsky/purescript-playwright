module Test.Main where

import Prelude
import Playwright
import Effect (Effect)
import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Untagged.Union (asOneOf, fromOneOf)
import Test.Unit.Assert as Assert
import Data.Maybe (Maybe(..))

static :: String -> URL
static file =
  URL $ "file://" <> cwd <> "/test/static/" <> file

main :: Effect Unit
main = runTest do
  suite "browser" do
    test "launch" do
      browser <- launch firefox {}
      close browser
    test "textContent" do
      browser <- launch firefox {}
      page <- newPage browser {}
      void $ goto
        page
        (static "hello.html")
        {}
      text <- textContent page (Selector "body")
      Assert.equal (Just "hello\n") (fromOneOf text)
      close browser

foreign import cwd :: String
