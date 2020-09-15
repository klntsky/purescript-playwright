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
import Effect.Aff (Aff)
import Untagged.Union (type (|+|))
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Options
import Playwright.Internal (effCall, effProp)

launch :: BrowserType -> LaunchOptions -> Aff Browser
launch bt =
  effCall "launch" (\_ -> launch) bt >>>
  toAffE

close :: Browser |+| BrowserContext |+| Page -> Aff Unit
close =
  effCall "close" (\_ -> close) >>> toAffE

contexts :: Browser -> Effect (Array BrowserContext)
contexts =
  effCall "contexts" (\_ -> contexts)

isConnected :: Browser -> Effect Boolean
isConnected =
  effCall "isConnected" (\_ -> isConnected)

version :: Browser -> Effect String
version =
  effCall "version" (\_ -> version)

newPage :: Browser |+| BrowserContext -> NewpageOptions -> Aff Page
newPage sth =
  effCall "newPage" (\_ -> newPage) sth >>>
  toAffE

goForward :: Page -> GoOptions -> Aff (Null |+| Response)
goForward page =
  effCall "goForward" (\_ -> goForward) page >>>
  toAffE

goBack :: Page -> GoOptions -> Aff (Null |+| Response)
goBack page =
  effCall "goBack" (\_ -> goBack) page >>>
  toAffE

goto :: Page |+| Frame -> URL -> GotoOptions -> Aff (Null |+| Response)
goto sth url' =
  effCall "goto" (\_ -> goto) sth url' >>>
  toAffE

hover :: Page |+| Frame |+| ElementHandle -> HoverOptions -> Aff Unit
hover sth =
  effCall "hover" (\_ -> hover) sth >>>
  toAffE

innerHTML
  :: Page |+| Frame |+| ElementHandle
  -> Selector
  -> InnerHTMLOptions
  -> Aff String
innerHTML sth selector =
  effCall "innerHTML" (\_ -> innerHTML) sth selector

innerText
  :: Page |+| Frame |+| ElementHandle
  -> Selector
  -> InnerTextOptions
  -> Aff String
innerText sth selector =
  effCall "innerText" (\_ -> innerText) sth selector

isClosed :: Page -> Effect Boolean
isClosed = effCall "isClosed" \_ -> isClosed

keyboard :: Page -> Effect Keyboard
keyboard = effProp "keyboard"

-- | `sth.$(selector)`
query
  :: ElementHandle |+| Page |+| Frame -> Selector -> Aff ElementHandle
query sth =
  toAffE <<< effCall "$" (\_ -> query) sth

-- | `sth.$$(selector)`
queryMany
  :: ElementHandle |+| Page |+| Frame
  -> Selector
  -> Aff (Array ElementHandle)
queryMany sth =
  toAffE <<< effCall "$$" (\_ -> queryMany) sth

screenshot
  :: ElementHandle |+| Page -> ScreenshotOptions -> Aff Buffer
screenshot sth =
  effCall "screenshot" (\_ -> screenshot) sth >>>
  toAffE

textContent
  :: Page |+| Frame |+| ElementHandle -> Selector -> Aff (Null |+| String)
textContent sth =
  effCall "textContent" (\_ -> textContent) sth >>>
  toAffE

url
  :: Page |+| Frame |+| Download |+| Request |+| Response |+| Worker
  -> Effect String
url = effCall "url" \_ -> url
