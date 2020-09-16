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
import Untagged.Coercible (class Coercible, coerce)
import Untagged.Union (type (|+|))
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Options
import Playwright.Internal (effCall, effProp)

launch
  :: forall o
  .  Coercible o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch bt opts =
  toAffE $ effCall "launch" typeInfo bt (coerce opts :: LaunchOptions)
  where
    typeInfo _ = launch :: BrowserType -> o -> Aff Browser

close
  :: forall x
  .  Coercible x (Browser |+| BrowserContext |+| Page)
  => x -> Aff Unit
close x =
  toAffE $ effCall "close" typeInfo x
  where typeInfo _ = close :: x -> Aff Unit

contexts :: Browser -> Effect (Array BrowserContext)
contexts =
  effCall "contexts" (\_ -> contexts)

isConnected :: Browser -> Effect Boolean
isConnected =
  effCall "isConnected" (\_ -> isConnected)

version :: Browser -> Effect String
version =
  effCall "version" (\_ -> version)

newPage
  :: forall x o
  .  Coercible x (Browser |+| BrowserContext)
  => Coercible o NewpageOptions
  => x -> o -> Aff Page
newPage sth opts =
  toAffE $ effCall "newPage" typeInfo sth (coerce opts :: NewpageOptions)
  where typeInfo _ = newPage :: x -> o -> Aff Page

goForward
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward page opts =
  toAffE $ effCall "goForward" typeInfo page (coerce opts :: GoOptions)
  where typeInfo _ = goForward :: Page -> o -> Aff (Null |+| Response)

goBack
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack page opts =
  toAffE $ effCall "goBack" typeInfo page (coerce opts :: GoOptions)
  where typeInfo _ = goBack :: Page -> o -> Aff (Null |+| Response)

goto
  :: forall x o
  .  Coercible x (Page |+| Frame)
  => Coercible o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto x url' opts =
  toAffE $ effCall "goto" typeInfo x url' (coerce opts :: GotoOptions)
  where typeInfo _ = goto :: x -> URL -> o -> Aff (Null |+| Response)

hover
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o HoverOptions
  => x -> o -> Aff Unit
hover sth opts =
  toAffE $ effCall "hover" typeInfo sth (coerce opts :: HoverOptions)
  where typeInfo _ = hover :: x -> o -> Aff Unit

innerHTML
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o InnerHTMLOptions
  => x -> Selector -> o -> Aff String
innerHTML x selector o =
  toAffE $ effCall "innerHTML" typeInfo x selector (coerce o :: InnerHTMLOptions)
  where typeInfo _ = innerHTML
          :: x
          -> Selector
          -> o
          -> Aff String

innerText
  :: forall x o
  .  Coercible o InnerTextOptions
  => Coercible x (Page |+| Frame |+| ElementHandle)
  => x
  -> Selector
  -> o
  -> Aff String
innerText x sel o =
  toAffE $ effCall "innerText" typeInfo x sel o
  where typeInfo _ = innerText
          :: x -> Selector -> o -> Aff String

isClosed :: Page -> Effect Boolean
isClosed = effCall "isClosed" \_ -> isClosed

keyboard :: Page -> Effect Keyboard
keyboard = effProp "keyboard"

-- | `sth.$(selector)`
query
  :: forall x
  .  Coercible x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff ElementHandle
query x sel =
  toAffE $ effCall "$" typeInfo x sel
  where typeInfo _ = query :: x -> Selector -> Aff ElementHandle

-- | `sth.$$(selector)`
queryMany
  :: forall x
  .  Coercible x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Array ElementHandle)
queryMany sth sel =
  toAffE $ effCall "$$" typeInfo sth sel
  where typeInfo _ = queryMany :: x -> Selector -> Aff (Array ElementHandle)

screenshot
  :: forall x o
  .  Coercible x (ElementHandle |+| Page)
  => Coercible o ScreenshotOptions
  => x -> o -> Aff Buffer
screenshot x o =
  toAffE $ effCall "screenshot" typeInfo x (coerce o :: ScreenshotOptions)
  where typeInfo _ = screenshot :: x -> o -> Aff Buffer

textContent
  :: forall x
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => x -> Selector -> Aff (Null |+| String)
textContent x sel =
  toAffE $ effCall "textContent" typeInfo x sel
  where typeInfo _ = textContent :: x -> Selector -> Aff (Null |+| String)

url
  :: forall x
  .  Coercible x (Page |+| Frame |+| Download |+| Request |+| Response |+| Worker)
  => x
  -> Effect String
url = effCall "url" typeInfo
  where typeInfo _ = url :: x -> Effect String
