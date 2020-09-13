module Playwright.Data where

import Prelude
import Untagged.TypeCheck (class HasRuntimeType)
import Foreign (isNull)

foreign import data BrowserType :: Type
foreign import data Browser :: Type
foreign import data BrowserContext :: Type
foreign import data Page :: Type
foreign import data Frame :: Type
foreign import data ElementHandle :: Type
foreign import data JSHandle :: Type
foreign import data ConsoleMessage :: Type
foreign import data Dialog :: Type
foreign import data Download :: Type
foreign import data FileChooser :: Type
foreign import data Keyboard :: Type
foreign import data Mouse :: Type
foreign import data Request :: Type
foreign import data Response :: Type
foreign import data Selectors :: Type
foreign import data Route :: Type
foreign import data Worker :: Type

foreign import data ScreenshotType :: Type

foreign import png :: ScreenshotType
foreign import jpg :: ScreenshotType

newtype Selector = Selector String
derive newtype instance eqSelector :: Eq Selector
derive newtype instance showSelector :: Show Selector
derive newtype instance ordSelector :: Ord Selector

newtype URL = URL String
derive newtype instance eqURL :: Eq URL
derive newtype instance showURL :: Show URL
derive newtype instance ordURL :: Ord URL

foreign import firefox :: BrowserType
foreign import chromium :: BrowserType
foreign import webkit :: BrowserType

foreign import data WaitUntil :: Type
foreign import domcontentloaded :: WaitUntil
foreign import load :: WaitUntil
foreign import networkidle :: WaitUntil

-- | We need our own `null` to make it usable with `untagged-union`.
-- | TODO: push upstream?
foreign import data Null :: Type

foreign import null :: Null

instance eqNull :: Eq Null where
  eq _ _ = true

instance showNull :: Show Null where
  show _ = "null"

instance ordNull :: Ord Null where
  compare _ _ = EQ

instance hasRuntimeTypeNull :: HasRuntimeType Null where
  hasRuntimeType _ = isNull
