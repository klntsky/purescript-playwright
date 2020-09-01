module Playwright
    ( BrowserType
    , Browser

    , firefox
    , chromium
    , webkit

    , launch
    , LaunchOptions
    , headless
    , executablePath
    , args
    , ignoreDefaultArgs
    , ProxyOptions
    , server
    , bypass
    , username
    , password
    , proxy
    , downloadsPath
    , chromiumSandbox
    , firefoxUserPrefs
    , handleSIGINT
    , handleSIGTERM
    , handleSIGHUP
    , timeout
    , env
    , devtools
    , slowMo

    , class Close
    , close

    , class NewPage
    , newPage
    , NewpageOptions

    , Frame
    , ElementHandle
    , Page

    , class Query
    , query
    , queryMany
    )
where

import Prelude
import Effect (Effect)
import Control.Promise (Promise, toAffE)
import Data.Options (Option, Options, opt, options)
import Effect.Aff (Aff)
import Foreign (Foreign)
import Foreign.Object (Object)

foreign import data BrowserType :: Type
foreign import data Browser :: Type

foreign import firefox :: BrowserType
foreign import chromium :: BrowserType
foreign import webkit :: BrowserType

foreign import _launch :: BrowserType -> Foreign -> Effect (Promise Browser)

launch :: BrowserType -> Options LaunchOptions -> Aff Browser
launch bt opts = toAffE $ _launch bt (options opts)

foreign import data LaunchOptions :: Type

headless :: Option LaunchOptions Boolean
headless = opt "headless"

executablePath :: Option LaunchOptions String
executablePath = opt "executablePath"

args :: Option LaunchOptions String
args = opt "args"

ignoreDefaultArgs :: Option LaunchOptions (Array String)
ignoreDefaultArgs = opt "ignoreDefaultArgs"

foreign import data ProxyOptions :: Type

server :: Option ProxyOptions String
server = opt "server"

bypass :: Option ProxyOptions String
bypass = opt "bypass"

username :: Option ProxyOptions String
username = opt "username"

password :: Option ProxyOptions String
password = opt "password"

proxy :: Option LaunchOptions (Options ProxyOptions)
proxy = opt "proxy"

downloadsPath :: Option LaunchOptions String
downloadsPath = opt "downloadsPath"

chromiumSandbox :: Option LaunchOptions Boolean
chromiumSandbox = opt "chromiumSandbox"

firefoxUserPrefs :: Option LaunchOptions Foreign
firefoxUserPrefs = opt "firefoxUserPrefs"

handleSIGINT :: Option LaunchOptions Boolean
handleSIGINT = opt "handleSIGINT"

handleSIGTERM :: Option LaunchOptions Boolean
handleSIGTERM = opt "handleSIGTERM"

handleSIGHUP :: Option LaunchOptions Boolean
handleSIGHUP = opt "handleSIGHUP"

timeout :: Option LaunchOptions Number
timeout = opt "timeout"

env :: Option LaunchOptions (Object String)
env = opt "env"

devtools :: Option LaunchOptions Boolean
devtools = opt "devtools"

slowMo :: Option LaunchOptions Number
slowMo = opt "slowMo"

class Close sth

instance closeBrowser :: Close Browser

close :: forall sth. Close sth => sth -> Aff Unit
close = toAffE <<< _close

foreign import _close :: forall sth. sth -> Effect (Promise Unit)

foreign import data BrowserContext :: Type

foreign import contexts :: Browser -> Effect (Array BrowserContext)

foreign import isConnected :: Browser -> Effect Boolean

foreign import version :: Browser -> Effect String

foreign import data NewpageOptions :: Type

foreign import data Page :: Type

class NewPage sth

instance newpageBrowser :: NewPage Browser
instance newpageBrowserContext :: NewPage BrowserContext

newPage :: forall sth. NewPage sth => sth -> Options NewpageOptions -> Aff Page
newPage sth opts = toAffE $ _newPage sth (options opts)

foreign import _newPage :: forall sth. sth -> Foreign -> Effect (Promise Page)

foreign import data ElementHandle :: Type

class Query sth

instance queryElementHandle :: Query ElementHandle
instance queryPage :: Query Page
instance queryFrame :: Query Frame

type Selector = String

foreign import data Frame :: Type

foreign import query_ :: forall sth. sth -> Selector -> Effect (Promise ElementHandle)
foreign import queryMany_ :: forall sth. sth -> Selector -> Effect (Promise (Array ElementHandle))

query :: forall sth. Query sth => sth -> Selector -> Aff ElementHandle
query sth = toAffE <<< query_ sth

queryMany :: forall sth. Query sth => sth -> Selector -> Aff (Array ElementHandle)
queryMany sth = toAffE <<< queryMany_ sth
