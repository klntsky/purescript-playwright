module Playwright
    ( launch
    , close
    , contexts
    , isConnected
    , version
    , newPage
    , goForward
    , goBack
    , goto
    , addCookies
    , hover
    , innerHTML
    , innerText
    , isClosed
    , keyboard
    , mainFrame
    , name
    , query
    , queryMany
    , screenshot
    , textContent
    , url
    , module Playwright.Data
    , module Playwright.Options
    )
where

import Effect (Effect)
import Effect.Aff (Aff)
import Literals.Null (Null)
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Internal (effCall, effProp, affCall)
import Playwright.Options
import Prelude
import Untagged.Coercible (class Coercible)
import Untagged.Union (type (|+|), UndefinedOr)

launch
  :: forall o
  .  Coercible o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch bt opts =
  affCall "launch" typeInfo bt opts
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
  where typeInfo _ = newPage

goForward
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward page opts =
  affCall "goForward" typeInfo page opts
  where typeInfo _ = goForward

goBack
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack page opts =
  affCall "goBack" typeInfo page opts
  where typeInfo _ = goBack

goto
  :: forall x o
  .  Coercible x (Page |+| Frame)
  => Coercible o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto x url' opts =
  affCall "goto" typeInfo x url' opts
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
  where typeInfo _ = addCookies

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
innerHTML x selector opts =
  affCall "innerHTML" typeInfo x selector opts
  where typeInfo _ = innerHTML

innerText
  :: forall x o
  .  Coercible o InnerTextOptions
  => Coercible x (Page |+| Frame |+| ElementHandle)
  => x
  -> Selector
  -> o
  -> Aff String
innerText x sel opts =
  affCall "innerText" typeInfo x sel opts
  where typeInfo _ = innerText :: x -> Selector -> o -> Aff String

isClosed :: Page -> Effect Boolean
isClosed = effCall "isClosed" \_ -> isClosed

keyboard :: Page -> Effect Keyboard
keyboard = effProp "keyboard"

mainFrame :: Page -> Effect Frame
mainFrame = effCall "mainFrame" \_ -> mainFrame

name :: Frame -> Effect String
name = effCall "name" \_ -> name

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
  -> Effect URL
url x = effCall "url" typeInfo x
  where typeInfo _ = url
