module Playwright
    ( launch
    , contexts
    , isConnected
    , version
    , close
    , newPage
    , query
    , queryMany
    , module Playwright.Data
    , module Playwright.Options
    )
where

import Prelude
import Effect (Effect)
import Control.Promise (toAffE)
import Data.Options (Options, options)
import Effect.Aff (Aff)
import Untagged.Union (type (|+|))
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Options
import Playwright.Internal (prop)

launch :: BrowserType -> Options Launch -> Aff Browser
launch bt =
  options >>>
  prop "launch" (\_ -> launch) bt >>>
  toAffE

close :: Browser |+| BrowserContext |+| Page -> Aff Unit
close =
  prop "close" (\_ -> close) >>> toAffE

contexts :: Browser -> Effect (Array BrowserContext)
contexts =
  prop "contexts" (\_ -> contexts)

isConnected :: Browser -> Effect Boolean
isConnected =
  prop "isConnected" (\_ -> isConnected)

version :: Browser -> Effect String
version =
  prop "version" (\_ -> version)

newPage :: Browser |+| BrowserContext -> Options Newpage -> Aff Page
newPage sth =
  options >>>
  prop "newPage" (\_ -> newPage) sth >>>
  toAffE

-- | `sth.$(selector)`
query
  :: ElementHandle |+| Page |+| Frame
  -> Selector
  -> Aff ElementHandle
query sth =
  toAffE <<< prop "$" (\_ -> query) sth

-- | `sth.$$(selector)
queryMany
  :: ElementHandle |+| Page |+| Frame
  -> Selector
  -> Aff (Array ElementHandle)
queryMany sth =
  toAffE <<< prop "$$" (\_ -> queryMany) sth

screenshot
  :: ElementHandle |+| Page
  -> Options Screenshot
  -> Aff Buffer
screenshot sth =
  options >>>
  prop "screenshot" (\_ -> screenshot) sth >>>
  toAffE

url
  :: Page |+| Frame |+| Download |+| Request |+| Response |+| Worker
  -> Effect String
url = prop "url" \_ -> url
