module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Test.Unit.Assert as Assert
import Playwright
import Data.Options
import Test.Unit
import Test.Unit.Main

main :: Effect Unit
main = runTest do
  suite "browser" do
    test "launch" do
      browser <- launch firefox $
        headless := false <>
        slowMo := 10000.0

      -- close browser
      pure unit
