module Playwright
    ( launch
    , contexts
    , isConnected
    , version
    , close
    , newPage
    , goto
    , query
    , queryMany
    , screenshot
    , textContent
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
import Playwright.Internal (effProp)
import Literals.Null

launch :: BrowserType -> Options Launch -> Aff Browser
launch bt =
  options >>>
  effProp "launch" (\_ -> launch) bt >>>
  toAffE

close :: Browser |+| BrowserContext |+| Page -> Aff Unit
close =
  effProp "close" (\_ -> close) >>> toAffE

contexts :: Browser -> Effect (Array BrowserContext)
contexts =
  effProp "contexts" (\_ -> contexts)

isConnected :: Browser -> Effect Boolean
isConnected =
  effProp "isConnected" (\_ -> isConnected)

version :: Browser -> Effect String
version =
  effProp "version" (\_ -> version)

newPage :: Browser |+| BrowserContext -> Options Newpage -> Aff Page
newPage sth =
  options >>>
  effProp "newPage" (\_ -> newPage) sth >>>
  toAffE

goto
  :: Page |+| Frame
  -> URL
  -> Options Goto
  -> Aff (Null |+| Response)
goto sth url' =
  options >>>
  effProp "goto" (\_ -> goto) sth url' >>>
  toAffE

-- | `sth.$(selector)`
query
  :: ElementHandle |+| Page |+| Frame
  -> Selector
  -> Aff ElementHandle
query sth =
  toAffE <<< effProp "$" (\_ -> query) sth

-- | `sth.$$(selector)`
queryMany
  :: ElementHandle |+| Page |+| Frame
  -> Selector
  -> Aff (Array ElementHandle)
queryMany sth =
  toAffE <<< effProp "$$" (\_ -> queryMany) sth

screenshot
  :: ElementHandle |+| Page
  -> Options Screenshot
  -> Aff Buffer
screenshot sth =
  options >>>
  effProp "screenshot" (\_ -> screenshot) sth >>>
  toAffE

textContent
  :: Page |+| Frame |+| ElementHandle
  -> Selector
  -> Aff (Null |+| String)
textContent sth =
  effProp "textContent" (\_ -> textContent) sth >>>
  toAffE

url
  :: Page |+| Frame |+| Download |+| Request |+| Response |+| Worker
  -> Effect String
url = effProp "url" \_ -> url
