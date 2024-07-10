module Playwright.Types where

import Playwright.Data (SameSite)

type Cookie =
  { name :: String
  , value :: String
  , domain :: String
  , path :: String
  , expires :: Number
  , httpOnly :: Boolean
  , secure :: Boolean
  , sameSite :: SameSite
  }
