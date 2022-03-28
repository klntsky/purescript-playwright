module Playwright
    ( launch
    , close
    , contexts
    , context
    , isConnected
    , version
    , newPage
    , goForward
    , goBack
    , goto
    , addCookies
    , cookies
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
    , waitForFunction
    , waitForLoadState
    , waitForTimeout
    , pdf
    , setInputFiles
    , setViewportSize
    , title
    , exposeBinding
    , fill
    , focus
    , onResponse
    , connect
    , module Playwright.Data
    , module Playwright.Options
    )
where

import Control.Promise (Promise, fromAff, toAffE)
import Data.String.Regex (Regex)
import Effect (Effect)
import Effect.Aff (Aff)
import Foreign (Foreign, unsafeToForeign)
import Literals.Null (Null)
import Node.Buffer (Buffer)
import Playwright.Data
import Playwright.Internal (effCall, effProp, affCall)
import Playwright.Options
import Prelude (Unit, ($))
import Undefined (undefined)
import Untagged.Castable (class Castable)
import Untagged.Union (type (|+|), UndefinedOr)
import Playwright.Types (Cookie)

foreign import onResponse :: Page -> (Response -> Effect Unit) -> Effect Unit

fill
  :: forall o
  . Castable o FillOptions
  => Page -> Selector -> String -> o -> Aff Unit
fill = affCall "fill" \_ -> fill

focus
  :: forall o
  . Castable o FocusOptions
  => Page -> Selector -> o -> Aff Unit
focus = affCall "focus" \_ -> focus

launch
  :: forall o
  .  Castable o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch =
  affCall "launch" \_ -> launch

close
  :: forall x
  .  Castable x (Browser |+| BrowserContext |+| Page)
  => x -> Aff Unit
close =
  affCall "close" \_ -> close

contexts :: Browser -> Effect (Array BrowserContext)
contexts =
  effCall "contexts" (\_ -> contexts)

type WebSocketEndpoint = String

connect
  :: forall o
  . Castable o ConnectOptions
  => BrowserType -> WebSocketEndpoint -> o -> Aff Browser
connect = affCall "connect" (\_ -> connect)

isConnected :: Browser -> Effect Boolean
isConnected =
  effCall "isConnected" (\_ -> isConnected)

version :: Browser -> Effect String
version =
  effCall "version" (\_ -> version)

newPage
  :: forall x o
  .  Castable x (Browser |+| BrowserContext)
  => Castable o NewpageOptions
  => x -> o -> Aff Page
newPage =
  affCall "newPage" \_ -> newPage

goForward
  :: forall o
  .  Castable o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward =
  affCall "goForward" \_ -> goForward

goBack
  :: forall o
  .  Castable o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack  =
  affCall "goBack" \_ -> goBack

goto
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto =
  affCall "goto" \_ -> goto

foreign import context :: Page -> BrowserContext 

cookies
  :: BrowserContext
  -> Aff (Array Cookie)
cookies =
  affCall "cookies" \_ -> cookies
  
addCookies
  :: BrowserContext
  -> Array Cookie
  -> Aff Unit
addCookies =
  affCall "addCookies" \_ -> addCookies

hover
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o HoverOptions
  => x -> o -> Aff Unit
hover =
  affCall "hover" \_ -> hover

innerHTML
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o InnerHTMLOptions
  => x -> Selector -> o -> Aff String
innerHTML =
  affCall "innerHTML" \_ -> innerHTML

innerText
  :: forall x o
  .  Castable o InnerTextOptions
  => Castable x (Page |+| Frame |+| ElementHandle)
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
  .  Castable x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Null |+| ElementHandle)
query =
  affCall "$" \_ -> query

-- | `sth.$$(selector)`
queryMany
  :: forall x
  .  Castable x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Array ElementHandle)
queryMany =
  affCall "$$" \_ -> queryMany

screenshot
  :: forall x o
  .  Castable x (ElementHandle |+| Page)
  => Castable o ScreenshotOptions
  => x -> o -> Aff Buffer
screenshot =
  affCall "screenshot" \_ -> screenshot

textContent
  :: forall x
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => x -> Selector -> Aff (Null |+| String)
textContent =
  affCall "textContent" \_ -> textContent

url
  :: forall x
  .  Castable x (Page |+| Frame |+| Download |+| Request |+| Response |+| Worker)
  => x
  -> Effect URL
url =
  effCall "url" \_ -> url

addInitScript
  :: forall x o
  .  Castable x (Page |+| BrowserContext)
  => Castable o AddInitScriptOptions
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
  .  Castable x (Page |+| Frame)
  => Castable o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
click =
  affCall "click" \_ -> click

content
  :: forall x
  . Castable x (Page |+| Frame)
  => x
  -> Aff String
content =
  affCall "content" \_ -> content

dblclick
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
dblclick =
  affCall "dblclick" \_ -> dblclick

evaluate
  :: forall x
  .  Castable x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff Foreign
evaluate =
  affCall "evaluate" \_ -> evaluate

evaluateHandle
  :: forall x
  .  Castable x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff JSHandle
evaluateHandle =
  affCall "evaluateHandle" \_ -> evaluateHandle

waitForNavigation
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForNavigationOptions
  => x
  -> o
  -> Aff (Null |+| Response)
waitForNavigation =
  affCall "waitForNavigation" \_ -> waitForNavigation

waitForRequest
  :: forall url o
  .  Castable url (URL |+| Regex |+| URL -> Boolean)
  => Castable o WaitForRequestOptions
  => Page
  -> url
  -> o
  -> Aff Request
waitForRequest = affCall "waitForRequest" \_ -> waitForRequest

waitForResponse
  :: forall url o
  .  Castable url (URL |+| Regex |+| URL -> Boolean)
  => Castable o WaitForResponseOptions
  => Page
  -> url
  -> o
  -> Aff Response
waitForResponse = affCall "waitForResponse" \_ -> waitForResponse

waitForSelector
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o WaitForSelectorOptions
  => x
  -> Selector
  -> o
  -> Aff (Null |+| ElementHandle)
waitForSelector = affCall "waitForSelector" \_ -> waitForSelector

waitForFunction
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForFunctionOptions
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> o
  -> Aff JSHandle
waitForFunction x s o = waitForFunction' x s (unsafeToForeign undefined) o
  where
    waitForFunction' = affCall "waitForFunction" \_ -> waitForFunction'

waitForLoadState
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForLoadStateOptions
  => x
  -> WaitUntil
  -> o
  -> Aff Unit
waitForLoadState = affCall "waitForLoadState" \_ -> waitForLoadState

waitForTimeout
  :: forall x
  .  Castable x (Page |+| Frame)
  => x
  -> Int
  -> Aff Unit
waitForTimeout = affCall "waitForTimeout" \_ -> waitForTimeout

pdf
  :: forall o
  .  Castable o PdfOptions
  => Page
  -> o
  -> Aff Buffer
pdf = affCall "pdf" \_ -> pdf

setInputFiles
  :: forall x o f
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o SetFilesOptions
  => Castable f
     ( String
   |+| Array String
   |+| { name :: String
       , mimeType :: String
       , buffer :: Buffer
       }
   |+| Array { name :: String
             , mimeType :: String
             , buffer :: Buffer
             }
     )
  => x
  -> Selector
  -> f
  -> o
  -> Aff Unit
setInputFiles = affCall "setInputFiles" \_ -> setInputFiles

setViewportSize
  :: Page
  -> { width  :: Number
     , height :: Number
     }
  ->  Aff Unit
setViewportSize = affCall "setViewportSize" \_ -> setViewportSize

title
  :: forall x
  .  Castable x (Page |+| Frame)
  => x
  -> Aff String
title = affCall "title" \_ -> title

exposeBinding
  :: forall x b
  .  Castable x (Page |+| BrowserContext)
  => x
  -> String
  -- ^ Name of the function on the window object.
  ->
  (
    { browserContext :: BrowserContext
    , page :: Page
    , frame :: Frame
    }
    -> Foreign
    -> Aff b
  )
  -> Aff Unit
exposeBinding x binding f =
  toAffE $ exposeBinding_ x binding (\d a -> fromAff $ f d a) { handle: false }

foreign import exposeBinding_
  :: forall x a b
  .  x
  -> String
  ->
  (
    { browserContext :: BrowserContext
    , page :: Page
    , frame :: Frame
    }
    -> a
    -> Effect (Promise b)
  )
  -> { handle :: Boolean }
  -> Effect (Promise Unit)
