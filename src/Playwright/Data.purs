module Playwright.Data where

import Prelude

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

foreign import data Modifier :: Type

foreign import alt :: Modifier
foreign import control :: Modifier
foreign import meta :: Modifier
foreign import shift :: Modifier

foreign import data MouseButton :: Type
foreign import left :: MouseButton
foreign import right :: MouseButton
foreign import middle :: MouseButton

foreign import data ElementState :: Type
foreign import attached :: ElementState
foreign import detached :: ElementState
foreign import visible :: ElementState
foreign import hidden :: ElementState

foreign import data SameSite :: Type
foreign import strict :: SameSite
foreign import lax :: SameSite
foreign import none :: SameSite

foreign import data Raf :: Type
foreign import raf :: Raf
