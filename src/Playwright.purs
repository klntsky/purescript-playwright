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
    , addInitScript
    , clearCookies
    , click
    , content
    , dblclick
    , evaluate
    , evaluateHandle
    , waitForNavigation
    , waitForRequest
    , waitForResponse
    , waitForSelector
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
import Foreign (Foreign)
import Data.String.Regex (Regex)

launch
  :: forall o
  .  Coercible o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch =
  affCall "launch" \_ -> launch

close
  :: forall x
  .  Coercible x (Browser |+| BrowserContext |+| Page)
  => x -> Aff Unit
close =
  affCall "close" \_ -> close

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
newPage =
  affCall "newPage" typeInfo
  where typeInfo _ = newPage

goForward
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward =
  affCall "goForward" typeInfo
  where typeInfo _ = goForward

goBack
  :: forall o
  .  Coercible o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack  =
  affCall "goBack" typeInfo
  where typeInfo _ = goBack

goto
  :: forall x o
  .  Coercible x (Page |+| Frame)
  => Coercible o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto =
  affCall "goto" typeInfo
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
addCookies =
  affCall "addCookies" \_ -> addCookies

hover
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o HoverOptions
  => x -> o -> Aff Unit
hover =
  affCall "hover" \_ -> hover

innerHTML
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o InnerHTMLOptions
  => x -> Selector -> o -> Aff String
innerHTML =
  affCall "innerHTML" \_ -> innerHTML

innerText
  :: forall x o
  .  Coercible o InnerTextOptions
  => Coercible x (Page |+| Frame |+| ElementHandle)
  => x
  -> Selector
  -> o
  -> Aff String
innerText  =
  affCall "innerText" \_ -> innerText

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
query =
  affCall "$" \_ -> query

-- | `sth.$$(selector)`
queryMany
  :: forall x
  .  Coercible x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Array ElementHandle)
queryMany =
  affCall "$$" \_ -> queryMany

screenshot
  :: forall x o
  .  Coercible x (ElementHandle |+| Page)
  => Coercible o ScreenshotOptions
  => x -> o -> Aff Buffer
screenshot =
  affCall "screenshot" \_ -> screenshot

textContent
  :: forall x
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => x -> Selector -> Aff (Null |+| String)
textContent =
  affCall "textContent" \_ -> textContent

url
  :: forall x
  .  Coercible x (Page |+| Frame |+| Download |+| Request |+| Response |+| Worker)
  => x
  -> Effect URL
url =
  effCall "url" \_ -> url

addInitScript
  :: forall x o
  .  Coercible x (Page |+| BrowserContext)
  => Coercible o AddInitScriptOptions
  => x
  -> o
  -> Aff Unit
addInitScript =
  affCall "addInitScript" \_ -> addInitScript

clearCookies :: BrowserContext -> Aff Unit
clearCookies =
  affCall "clearCookies" \_ -> clearCookies

click
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
click =
  affCall "click" \_ -> click

content
  :: forall x
  . Coercible x (Page |+| Frame)
  => x
  -> Aff String
content =
  affCall "content" \_ -> content

dblclick
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
dblclick =
  affCall "dblclick" \_ -> dblclick

evaluate
  :: forall x
  .  Coercible x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff Foreign
evaluate =
  affCall "evaluate" \_ -> evaluate

evaluateHandle
  :: forall x
  .  Coercible x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff JSHandle
evaluateHandle =
  affCall "evaluateHandle" \_ -> evaluateHandle

waitForNavigation
  :: forall x o
  .  Coercible x (Page |+| Frame)
  => Coercible o WaitForNavigationOptions
  => x
  -> o
  -> Aff (Null |+| Response)
waitForNavigation =
  affCall "waitForNavigation" \_ -> waitForNavigation

waitForRequest
  :: forall url o
  .  Coercible url (URL |+| Regex |+| URL -> Boolean)
  => Coercible o WaitForRequestOptions
  => Page
  -> url
  -> o
  -> Aff Request
waitForRequest = affCall "waitForRequest" \_ -> waitForRequest

waitForResponse
  :: forall url o
  .  Coercible url (URL |+| Regex |+| URL -> Boolean)
  => Coercible o WaitForResponseOptions
  => Page
  -> url
  -> o
  -> Aff Response
waitForResponse = affCall "waitForResponse" \_ -> waitForResponse

waitForSelector
  :: forall x o
  .  Coercible x (Page |+| Frame |+| ElementHandle)
  => Coercible o WaitForSelectorOptions
  => x
  -> Selector
  -> o
  -> Aff (Null |+| ElementHandle)
waitForSelector = affCall "waitForSelector" \_ -> waitForSelector
