module Playwright.Options where

import Playwright.Data

import Foreign.Object (Object)
import Foreign (Foreign)
import Untagged.Union (UndefinedOr, type (|+|))
import Untagged.Coercible (class Coercible, coerce)

-- | A "no options" value, defined as `coerce {}`.
empty :: forall a. Coercible {} a => a
empty = coerce {}

type Op a = UndefinedOr a

type LaunchOptions =
  { headless          :: Op Boolean
  , executablePath    :: Op String
  , args              :: Op String
  , ignoreDefaultArgs :: Op (Array String)
  , proxy             :: Op ProxyOptions
  , downloadsPath     :: Op String
  , chromiumSandbox   :: Op Boolean
  , firefoxUserPrefs  :: Op Foreign
  , handleSIGINT      :: Op Boolean
  , handleSIGTERM     :: Op Boolean
  , handleSIGHUP      :: Op Boolean
  , timeout           :: Op Number
  , env               :: Op (Object String)
  , devtools          :: Op Boolean
  , slowMo            :: Op Number
  }

type ProxyOptions =
  { server   :: Op String
  , bypass   :: Op String
  , username :: Op String
  , password :: Op String
  }

type ScreenshotOptions =
  { path           :: Op String
  , "type"         :: Op ScreenshotType
  , quality        :: Op Number
  , omitBackground :: Op Boolean
  , timeout        :: Op Number
  }

type GotoOptions =
  { timeout   :: Op Int
  , waitUntil :: Op WaitUntil
  , referer   :: Op String
  }

type NewpageOptions =
  { acceptDownloads   :: Op Boolean
  , ignoreHTTPSErrors :: Op Boolean
  , bypassCSP         :: Op Boolean
  , viewport          :: Op (Null |+| { width :: Int, height :: Int })
  }

type GoOptions =
  { timeout   :: Op Int
  , waitUntil :: Op WaitUntil
  }

type HoverOptions =
  { position :: Op { x :: Number, y :: Number }
  , modifier :: Op (Array Modifier)
  , force    :: Op Boolean
  }

type InnerHTMLOptions =
  { timeout :: Op Number
  }

type InnerTextOptions =
  { timeout :: Op Number
  }

type KeyboardPressOptions =
  { delay :: Op Int
  }
