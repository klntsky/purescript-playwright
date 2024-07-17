module Playwright.Event where

import Type.Proxy (Proxy(..))
import Effect (Effect)
import Prelude
import Playwright.Data (Browser, BrowserContext, ConsoleMessage)
import Playwright.Data as Data
import Effect.Exception (Error)

class Event :: forall k. k -> Constraint
class Event e where
  getEventName :: Proxy e -> String

class OnEvent :: forall k1 k2 k3. k1 -> k2 -> k3 -> Constraint
class Event e <= OnEvent x e a | x e -> a

-- | Our own `Proxy` for event names.
data EventName :: forall k. k -> Type
data EventName a = EventName

foreign import data Close :: Type

instance eventClose :: Event Close where
  getEventName _ = "close"

instance eventPageClose :: OnEvent Data.Page Close Unit
instance eventBrowserContextClose :: OnEvent BrowserContext Close Unit
instance eventBrowserClose :: OnEvent Browser Close Unit
instance eventWorkerClose :: OnEvent Worker Close Unit

close :: EventName Close
close = EventName

foreign import data Console :: Type

instance eventConsole :: Event Console where
  getEventName _ = "console"

instance eventPageConsole :: OnEvent Data.Page Console ConsoleMessage

console :: EventName Console
console = EventName

foreign import data Crash :: Type

instance eventCrash :: Event Crash where
  getEventName _ = "crash"

instance eventPageCrash :: OnEvent Data.Page Crash Unit

crash :: EventName Crash
crash = EventName

foreign import data Dialog :: Type

instance eventDialog :: Event Dialog where
  getEventName _ = "dialog"

instance eventPageDialog :: OnEvent Data.Page Dialog Data.Dialog

dialog :: EventName Dialog
dialog = EventName

foreign import data DomContentLoaded :: Type

instance eventDomContentLoaded :: Event DomContentLoaded where
  getEventName _ = "domcontentloaded"

instance eventPageDomContentLoaded :: OnEvent Data.Page DomContentLoaded Unit

domcontentloaded :: EventName DomContentLoaded
domcontentloaded = EventName

foreign import data Download :: Type

instance eventDownload :: Event Download where
  getEventName _ = "download"

instance eventPageDownload :: OnEvent Data.Page Download Data.Download

download :: EventName Download
download = EventName

foreign import data FileChooser :: Type

instance eventFileChooser :: Event FileChooser where
  getEventName _ = "filechooser"

instance eventPageFileChooser :: OnEvent Data.Page FileChooser Data.FileChooser

filechooser :: EventName FileChooser
filechooser = EventName

foreign import data PageError :: Type

instance eventPageError :: Event PageError where
  getEventName _ = "pageerror"

instance eventPagePageError :: OnEvent Data.Page PageError Error

pageerror :: EventName PageError
pageerror = EventName

foreign import data Popup :: Type

instance eventPopup :: Event Popup where
  getEventName _ = "popup"

instance eventPagePopup :: OnEvent Data.Page Popup Page

popup :: EventName Popup
popup = EventName

foreign import data Request :: Type

instance eventRequest :: Event Request where
  getEventName _ = "request"

instance eventPageRequest :: OnEvent Data.Page Request Data.Request

request :: EventName Request
request = EventName

foreign import data RequestFailed :: Type

instance eventRequestFailed :: Event RequestFailed where
  getEventName _ = "requestfailed"

instance eventPageRequestFailed :: OnEvent Data.Page RequestFailed Data.Request

requestfailed :: EventName RequestFailed
requestfailed = EventName

foreign import data RequestFinished :: Type

instance eventRequestFinished :: Event RequestFinished where
  getEventName _ = "requestfinished"

instance eventPageRequestFinished :: OnEvent Data.Page RequestFinished Data.Request

requestfinished :: EventName RequestFinished
requestfinished = EventName

foreign import data Response :: Type

instance eventResponse :: Event Response where
  getEventName _ = "response"

instance eventPageResponse :: OnEvent Data.Page Response Data.Response

response :: EventName Response
response = EventName

foreign import data Worker :: Type

instance eventWorker :: Event Worker where
  getEventName _ = "worker"

instance eventPageWorker :: OnEvent Data.Page Worker Data.Worker

worker :: EventName Worker
worker = EventName

foreign import data Page :: Type

instance eventPage :: Event Page where
  getEventName _ = "page"

instance eventPagePage :: OnEvent BrowserContext Page Data.Page

page :: EventName Page
page = EventName

on
  :: forall x e a r
   . OnEvent x e a
  => EventName e
  -> x
  -> (a -> Effect r)
  -> Effect Unit
on _ obj callback = onForeign obj (getEventName (Proxy :: Proxy e)) callback

foreign import onForeign :: forall x a r. x -> String -> (a -> Effect r) -> Effect Unit
