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
-- import Control.Promise (toAffE)
import Effect.Aff (Aff)
import Untagged.Coercible (class Coercible, coerce)
import Untagged.Union (type (|+|), UndefinedOr)
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Options
import Playwright.Internal (effCall, effProp, affCall)
import Literals.Null (Null)

launch
  :: forall o
  .  Coercible o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch bt opts =
  affCall "launch" typeInfo bt (coerce opts :: LaunchOptions)
  where
    typeInfo _ = launch

close
  :: forall x
  .  Coercible x (Browser |+| BrowserContext |+| Page)
  => x -> Aff Unit
close x =
  affCall "close" (\_ -> close) x

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
  affCall "newPage" typeInfo sth opts
  where typeInfo _ = newPage :: x -> o -> Aff Page

goForward
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward page opts =
  affCall "goForward" typeInfo page (coerce opts :: GoOptions)
  where typeInfo _ = goForward

goBack
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack page opts =
  affCall "goBack" typeInfo page (coerce opts :: GoOptions)
  where typeInfo _ = goBack

goto
  :: forall x o
  .  Coercible x (Page |+| Frame)
  => Coercible o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto x url' opts =
  affCall "goto" typeInfo x url' (coerce opts :: GotoOptions)
  where typeInfo _ = goto

type Cookie =
  { name :: String
  , value :: String
  , url :: UndefinedOr String
  }

addCookies
  :: BrowserContext
  -> Array Cookie
  -> Aff Unit
addCookies bc cookies =
  affCall "addCookies" typeInfo bc cookies
  where
    typeInfo _ = addCookies

hover
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o HoverOptions
  => x -> o -> Aff Unit
hover sth opts =
  affCall "hover" typeInfo sth opts
  where typeInfo _ = hover :: x -> o -> Aff Unit

innerHTML
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o InnerHTMLOptions
  => x -> Selector -> o -> Aff String
innerHTML x selector o =
  affCall "innerHTML" typeInfo x selector (coerce o :: InnerHTMLOptions)
  where typeInfo _ = innerHTML

innerText
  :: forall x o
  .  Coercible o InnerTextOptions
  => Coercible x (Page |+| Frame |+| ElementHandle)
  => x
  -> Selector
  -> o
  -> Aff String
innerText x sel o =
  affCall "innerText" typeInfo x sel o
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
query x =
  affCall "$" typeInfo x
  where typeInfo _ = query :: x -> Selector -> Aff ElementHandle

-- | `sth.$$(selector)`
queryMany
  :: forall x
  .  Coercible x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Array ElementHandle)
queryMany sth =
  affCall "$$" typeInfo sth
  where typeInfo _ = queryMany :: x -> Selector -> Aff (Array ElementHandle)

screenshot
  :: forall x o
  .  Coercible x (ElementHandle |+| Page)
  => Coercible o ScreenshotOptions
  => x -> o -> Aff Buffer
screenshot x o =
  affCall "screenshot" typeInfo x o
  where typeInfo _ = screenshot

textContent
  :: forall x
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => x -> Selector -> Aff (Null |+| String)
textContent x =
  affCall "textContent" typeInfo x
  where typeInfo _ = textContent

url
  :: forall x
  .  Coercible x (Page |+| Frame |+| Download |+| Request |+| Response |+| Worker)
  => x
  -> Effect String
url = effCall "url" typeInfo
  where typeInfo _ = url :: x -> Effect String
