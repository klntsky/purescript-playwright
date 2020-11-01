module Playwright.Options where

import Playwright.Data

import Data.String.Regex (Regex)
import Foreign (Foreign)
import Foreign.Object (Object)
import Literals.Null (Null)
import Untagged.Union (UndefinedOr, type (|+|))

type Opt a = UndefinedOr a

type LaunchOptions =
  { headless          :: Opt Boolean
  , executablePath    :: Opt String
  , args              :: Opt String
  , ignoreDefaultArgs :: Opt (Array String)
  , proxy             :: Opt ProxyOptions
  , downloadsPath     :: Opt String
  , chromiumSandbox   :: Opt Boolean
  , firefoxUserPrefs  :: Opt Foreign
  , handleSIGINT      :: Opt Boolean
  , handleSIGTERM     :: Opt Boolean
  , handleSIGHUP      :: Opt Boolean
  , timeout           :: Opt Number
  , env               :: Opt (Object String)
  , devtools          :: Opt Boolean
  , slowMo            :: Opt Number
  }

type ProxyOptions =
  { server   :: Opt String
  , bypass   :: Opt String
  , username :: Opt String
  , password :: Opt String
  }

type ScreenshotOptions =
  { path           :: Opt String
  , "type"         :: Opt ScreenshotType
  , quality        :: Opt Number
  , omitBackground :: Opt Boolean
  , timeout        :: Opt Number
  }

type GotoOptions =
  { timeout   :: Opt Int
  , waitUntil :: Opt WaitUntil
  , referer   :: Opt String
  }

type NewpageOptions =
  { acceptDownloads   :: Opt Boolean
  , ignoreHTTPSErrors :: Opt Boolean
  , bypassCSP         :: Opt Boolean
  , viewport          :: Opt (Null |+| { width :: Int, height :: Int })
  }

type GoOptions =
  { timeout   :: Opt Int
  , waitUntil :: Opt WaitUntil
  }

type HoverOptions =
  { position :: Opt Position
  , modifier :: Opt (Array Modifier)
  , force    :: Opt Boolean
  }

type InnerHTMLOptions =
  { timeout :: Opt Number
  }

type InnerTextOptions =
  { timeout :: Opt Number
  }

type KeyboardPressOptions =
  { delay :: Opt Int
  }

type AddInitScriptOptions =
  (String |+| { path :: Opt String, content :: Opt String })

type Position = { x :: Int, y :: Int }

type ClickOptions =
  { button      :: Opt MouseButton
  , clickCount  :: Opt Int
  , delay       :: Opt Int
  , position    :: Opt Position
  , modifiers   :: Opt (Array Modifier)
  , force       :: Opt Boolean
  , noWaitAfter :: Opt Boolean
  , timeout     :: Opt Int
  }

type MouseClickOptions =
  { button     :: Opt MouseButton
  , clickCount :: Opt Int
  , delay      :: Opt Int
  }

type MouseDblClickOptions =
  { button     :: Opt MouseButton
  , delay      :: Opt Int
  }

type MouseUpDownOptions =
  { button     :: Opt MouseButton
  , clickCount :: Opt Int
  }

type MouseMoveOptions =
  { steps :: Opt Int
  }

type WaitForNavigationOptions =
  { timeout   :: Opt Int
  , url       :: Opt (String |+| Regex |+| URL -> Boolean)
  , waitUntil :: Opt WaitUntil
  }
