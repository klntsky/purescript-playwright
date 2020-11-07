module Playwright.Event
where

import Type.Proxy (Proxy(..))
import Effect (Effect)
import Prelude (Unit)
import Playwright.Data
import Playwright.Data as Data

class Event e where
  getEventName :: Proxy e -> String

class Event e <= OnEvent x e a | x e -> a

-- | Our own `Proxy` for event names.
data EventName a = EventName

foreign import data Close :: Type
instance eventClose :: Event Close where getEventName _ = "close"
instance eventPageClose :: OnEvent Page Close Unit
close :: EventName Close
close = EventName

foreign import data Console :: Type
instance eventConsole :: Event Console where getEventName _ = "console"
instance eventPageConsole :: OnEvent Page Console ConsoleMessage
console :: EventName Console
console = EventName

foreign import data Crash :: Type
instance eventCrash :: Event Crash where getEventName _ = "crash"
instance eventPageCrash :: OnEvent Page Crash Unit
crash :: EventName Crash
crash = EventName

foreign import data Dialog :: Type
instance eventDialog :: Event Dialog where getEventName _ = "dialog"
instance eventPageDialog :: OnEvent Page Dialog Data.Dialog
dialog :: EventName Dialog
dialog = EventName

foreign import data DomContentLoaded :: Type
instance eventDomContentLoaded :: Event DomContentLoaded where
  getEventName _ = "domcontentloaded"
instance eventPageDomContentLoaded :: OnEvent Page DomContentLoaded Unit
domcontentloaded :: EventName DomContentLoaded
domcontentloaded = EventName

foreign import data Download :: Type
instance eventDownload :: Event Download where
  getEventName _ = "download"
instance eventPageDownload :: OnEvent Page Download Data.Download
download :: EventName Download
download = EventName

foreign import data FileChooser :: Type
instance eventFileChooser :: Event FileChooser where
  getEventName _ = "filechooser"
instance eventPageFileChooser :: OnEvent Page FileChooser Data.FileChooser
filechooser :: EventName FileChooser
filechooser = EventName

on
  :: forall x e a r
  .  OnEvent x e a
  => EventName e
  -> x
  -> (a -> Effect r)
  -> Effect Unit
on event obj callback = onForeign obj (getEventName (Proxy :: Proxy e)) callback

foreign import onForeign :: forall x a r. x -> String -> (a -> Effect r) -> Effect Unit
