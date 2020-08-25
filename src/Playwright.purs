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

    , close
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

close :: Browser -> Aff Unit
close = toAffE <<< _close

foreign import _close :: Browser -> Effect (Promise Unit)
