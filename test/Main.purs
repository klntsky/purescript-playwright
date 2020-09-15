module Test.Main where

import Prelude
import Playwright
import Effect (Effect)
import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Untagged.Union (asOneOf, fromOneOf)
import Untagged.Coercible
import Test.Unit.Assert as Assert
import Data.Maybe (Maybe(..))

static :: String -> URL
static file =
  URL $ "file://" <> cwd <> "/test/static/" <> file

main :: Effect Unit
main = runTest do
  suite "browser" do
    test "launch" do
      browser <- launch firefox (coerce {})
      close $ asOneOf browser
    test "textContent" do
      browser <- launch firefox (coerce {})
      page <- newPage (asOneOf browser) (coerce {})
      void $ goto
        (asOneOf page)
        (static "hello.html")
        (coerce {})
      text <- textContent (asOneOf page) (Selector "body")
      Assert.equal (Just "hello\n") (fromOneOf text)
      close $ asOneOf browser

foreign import cwd :: String
