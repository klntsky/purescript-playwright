module Playwright.Event
where

import Type.Proxy (Proxy(..))
import Effect (Effect)
import Prelude (Unit)
import Playwright.Data

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

on
  :: forall x e a r
  .  OnEvent x e a
  => EventName e
  -> x
  -> (a -> Effect r)
  -> Effect Unit
on event obj callback = onForeign obj (getEventName (Proxy :: Proxy e)) callback

foreign import onForeign :: forall x a r. x -> String -> (a -> Effect r) -> Effect Unit
