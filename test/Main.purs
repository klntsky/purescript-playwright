module Test.Main where

import Prelude
import Playwright (close, firefox, headless, launch, slowMo)
import Effect (Effect)
import Data.Options ((:=))
import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Untagged.Union (asOneOf)

main :: Effect Unit
main = runTest do
  suite "browser" do
    test "launch" do
      browser <- launch firefox $
        headless := false <>
        slowMo := 100.0
      close $ asOneOf browser
