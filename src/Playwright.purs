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
    , waitForFunction
    , waitForLoadState
    , waitForTimeout
    , pdf
    , setInputFiles
    , setViewportSize
    , title
    , exposeBinding
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
import Untagged.Castable (class Castable)
import Untagged.Union (type (|+|), UndefinedOr)

launch
  :: forall o
  .  Castable o LaunchOptions
  => BrowserType -> o -> Aff Browser
launch x o =
  toAffE $ launchImpl x o
foreign import launchImpl :: forall x o. x -> o -> Effect (Promise Browser)

close
  :: forall x
  .  Castable x (Browser |+| BrowserContext |+| Page)
  => x -> Aff Unit
close x =
  toAffE $ closeImpl x
foreign import closeImpl :: forall x. x -> Effect (Promise Unit)

contexts :: Browser -> Effect (Array BrowserContext)
contexts x = contextsImpl x
foreign import contextsImpl :: Browser -> Effect (Array BrowserContext)

isConnected :: Browser -> Effect Boolean
isConnected x = isConnectedImpl x
foreign import isConnectedImpl :: Browser -> Effect Boolean

version :: Browser -> Effect String
version x = versionImpl x
foreign import versionImpl :: Browser -> Effect String

newPage
  :: forall x o
  .  Castable x (Browser |+| BrowserContext)
  => Castable o NewpageOptions
  => x -> o -> Aff Page
newPage x o =
  toAffE $ newPageImpl x o
foreign import newPageImpl :: forall a b. a -> b -> Effect (Promise (Page))

goForward
  :: forall o
  .  Castable o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goForward p o = toAffE $ goForwardImpl p o
foreign import goForwardImpl :: forall a. Page -> a -> Effect (Promise (Null |+| Response))

goBack
  :: forall o
  .  Castable o GoOptions
  => Page -> o -> Aff (Null |+| Response)
goBack p o = toAffE $ goBackImpl p o
foreign import goBackImpl :: forall a. Page -> a -> Effect (Promise (Null |+| Response))

goto
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o GotoOptions
  => x -> URL -> o -> Aff (Null |+| Response)
goto x u o =
  toAffE $ gotoImpl x u o
foreign import gotoImpl :: forall a b. a -> URL -> b -> Effect (Promise (Null |+| Response))

type Cookie =
  { name :: String
  , value :: String
  , url :: UndefinedOr String
  }

addCookies
  :: BrowserContext
  -> Array Cookie
  -> Aff Unit
addCookies b cs =
  toAffE $ addCookiesImpl b cs
foreign import addCookiesImpl :: BrowserContext -> Array Cookie -> Effect (Promise Unit)

hover
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o HoverOptions
  => x -> o -> Aff Unit
hover x o =
  toAffE $ hoverImpl x o
foreign import hoverImpl :: forall a b. a -> b -> Effect (Promise Unit)

innerHTML
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o InnerHTMLOptions
  => x -> Selector -> o -> Aff String
innerHTML x s o =
  toAffE $ innerHTMLImpl x s o
foreign import innerHTMLImpl :: forall a b. a -> Selector -> b -> Effect (Promise String)

innerText
  :: forall x o
  .  Castable o InnerTextOptions
  => Castable x (Page |+| Frame |+| ElementHandle)
  => x
  -> Selector
  -> o
  -> Aff String
innerText x s o =
  toAffE $ innerTextImpl x s o
foreign import innerTextImpl :: forall a b. a -> Selector -> b -> Effect (Promise String)

isClosed :: Page -> Effect Boolean
isClosed x = isClosedImpl x
foreign import isClosedImpl :: Page -> Effect Boolean

keyboard :: Page -> Effect Keyboard
keyboard x = keyboardImpl x
foreign import keyboardImpl :: Page -> Effect Keyboard

mainFrame :: Page -> Effect Frame
mainFrame x = mainFrameImpl x
foreign import mainFrameImpl :: Page -> Effect Frame

name :: Frame -> Effect String
name x = nameImpl x
foreign import nameImpl :: Frame -> Effect String

-- | `sth.$(selector)`
query
  :: forall x
  .  Castable x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Null |+| ElementHandle)
query x s = toAffE $ queryImpl x s
foreign import queryImpl :: forall a. a -> Selector -> Effect (Promise (Null |+| ElementHandle))

-- | `sth.$$(selector)`
queryMany
  :: forall x
  .  Castable x (ElementHandle |+| Page |+| Frame)
  => x -> Selector -> Aff (Array ElementHandle)
queryMany x s = toAffE $ queryManyImpl x s
foreign import queryManyImpl :: forall a. a -> Selector -> Effect (Promise (Array ElementHandle))

screenshot
  :: forall x o
  .  Castable x (ElementHandle |+| Page)
  => Castable o ScreenshotOptions
  => x -> o -> Aff Buffer
screenshot x o = toAffE $ screenshotImpl x o
foreign import screenshotImpl :: forall a b. a -> b -> Effect (Promise Buffer)

textContent
  :: forall x
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => x -> Selector -> Aff (Null |+| String)
textContent x s = toAffE $ textContentImpl x s
foreign import textContentImpl :: forall a. a -> Selector -> Effect (Promise (Null |+| String))

url
  :: forall x
  .  Castable x (Page |+| Frame |+| Download |+| Request |+| Response |+| Worker)
  => x
  -> Effect URL
url x = urlImpl x
foreign import urlImpl :: forall a. a -> Effect URL

addInitScript
  :: forall x o
  .  Castable x (Page |+| BrowserContext)
  => Castable o AddInitScriptOptions
  => x
  -> o
  -> Aff Unit
addInitScript x o = toAffE $ addInitScriptImpl x o
foreign import addInitScriptImpl :: forall a b. a -> b -> Effect (Promise Unit)

clearCookies :: BrowserContext -> Aff Unit
clearCookies b = toAffE $ clearCookiesImpl b
foreign import clearCookiesImpl :: BrowserContext -> Effect (Promise Unit)

click
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
click x s o = toAffE $ clickImpl x s o
foreign import clickImpl :: forall a b. a -> Selector -> b -> Effect (Promise Unit)

content
  :: forall x
  . Castable x (Page |+| Frame)
  => x
  -> Aff String
content x = toAffE $ contentImpl x
foreign import contentImpl :: forall a. a -> Effect (Promise String)

dblclick
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o ClickOptions
  => x
  -> Selector
  -> o
  -> Aff Unit
dblclick x s o = toAffE $ dblclickImpl x s o
foreign import dblclickImpl :: forall a b. a -> Selector -> b -> Effect (Promise Unit)

evaluate
  :: forall x
  .  Castable x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff Foreign
evaluate x s =
  toAffE $ evaluateImpl x s
foreign import evaluateImpl :: forall a. a -> String -> Effect (Promise Foreign)

evaluateHandle
  :: forall x
  .  Castable x (Page |+| Frame |+| Worker |+| JSHandle)
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> Aff JSHandle
evaluateHandle x s =
  toAffE $ evaluateHandleImpl x s
foreign import evaluateHandleImpl :: forall a. a -> String -> Effect (Promise JSHandle)

waitForNavigation
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForNavigationOptions
  => x
  -> o
  -> Aff (Null |+| Response)
waitForNavigation x o =
  toAffE $ waitForNavigationImpl x o
foreign import waitForNavigationImpl :: forall a b. a -> b -> Effect (Promise (Null |+| Response))

waitForRequest
  :: forall url o
  .  Castable url (URL |+| Regex |+| URL -> Boolean)
  => Castable o WaitForRequestOptions
  => Page
  -> url
  -> o
  -> Aff Request
waitForRequest p u o =
  toAffE $ waitForRequestImpl p u o
foreign import waitForRequestImpl :: forall a b. Page -> a -> b -> Effect (Promise Request)

waitForResponse
  :: forall url o
  .  Castable url (URL |+| Regex |+| URL -> Boolean)
  => Castable o WaitForResponseOptions
  => Page
  -> url
  -> o
  -> Aff Response
waitForResponse p u o =
  toAffE $ waitForResponseImpl p u o
foreign import waitForResponseImpl :: forall a b. Page -> a -> b -> Effect (Promise Response)

waitForSelector
  :: forall x o
  .  Castable x (Page |+| Frame |+| ElementHandle)
  => Castable o WaitForSelectorOptions
  => x
  -> Selector
  -> o
  -> Aff (Null |+| ElementHandle)
waitForSelector x s o =
  toAffE $ waitForSelectorImpl x s o
foreign import waitForSelectorImpl :: forall a b. a -> Selector -> b -> Effect (Promise (Null |+| ElementHandle))

waitForFunction
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForFunctionOptions
  => x
  -> String
  -- ^ Function to be evaluated in browser context
  -> o
  -> Aff JSHandle
waitForFunction x s o = toAffE $ waitForFunctionImpl x s o
foreign import waitForFunctionImpl :: forall a b. a -> String -> b -> Effect (Promise JSHandle)

waitForLoadState
  :: forall x o
  .  Castable x (Page |+| Frame)
  => Castable o WaitForLoadStateOptions
  => x
  -> WaitUntil
  -> o
  -> Aff Unit
waitForLoadState x w o = toAffE $ waitForLoadStateImpl x w o
foreign import waitForLoadStateImpl :: forall a b. a -> WaitUntil -> b -> Effect (Promise Unit)

waitForTimeout
  :: forall x
  .  Castable x (Page |+| Frame)
  => x
  -> Int
  -> Aff Unit
waitForTimeout x t = toAffE $ waitForTimeoutImpl x t
foreign import waitForTimeoutImpl :: forall a. a -> Int -> Effect (Promise Unit)

pdf
  :: forall o
  .  Castable o PdfOptions
  => Page
  -> o
  -> Aff Buffer
pdf p o = toAffE $ pdfImpl p o
foreign import pdfImpl :: forall a. Page -> a -> Effect (Promise Buffer)

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
setInputFiles x s f o = toAffE $ setInputFilesImpl x s f o
foreign import setInputFilesImpl :: forall a b c. a -> Selector -> b -> c -> Effect (Promise Unit)

setViewportSize
  :: Page
  -> { width  :: Number
     , height :: Number
     }
  ->  Aff Unit
setViewportSize p o = toAffE $ setViewportSizeImpl p o
foreign import setViewportSizeImpl :: Page -> { width  :: Number, height :: Number } -> Effect (Promise Unit)

title
  :: forall x
  .  Castable x (Page |+| Frame)
  => x
  -> Aff String
title x = toAffE $ titleImpl x
foreign import titleImpl :: forall a. a -> Effect (Promise String)

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
