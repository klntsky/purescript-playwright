module Playwright.Options where

import Data.Options (Option, Options, opt, options)
import Playwright.Data
import Foreign.Object (Object)
import Foreign (Foreign)

foreign import data Launch :: Type
foreign import data Proxy :: Type

headless :: Option Launch Boolean
headless = opt "headless"

executablePath :: Option Launch String
executablePath = opt "executablePath"

args :: Option Launch String
args = opt "args"

ignoreDefaultArgs :: Option Launch (Array String)
ignoreDefaultArgs = opt "ignoreDefaultArgs"

proxy :: Option Launch (Options Proxy)
proxy = opt "proxy"

downloadsPath :: Option Launch String
downloadsPath = opt "downloadsPath"

chromiumSandbox :: Option Launch Boolean
chromiumSandbox = opt "chromiumSandbox"

firefoxUserPrefs :: Option Launch Foreign
firefoxUserPrefs = opt "firefoxUserPrefs"

handleSIGINT :: Option Launch Boolean
handleSIGINT = opt "handleSIGINT"

handleSIGTERM :: Option Launch Boolean
handleSIGTERM = opt "handleSIGTERM"

handleSIGHUP :: Option Launch Boolean
handleSIGHUP = opt "handleSIGHUP"

timeout :: Option Launch Number
timeout = opt "timeout"

env :: Option Launch (Object String)
env = opt "env"

devtools :: Option Launch Boolean
devtools = opt "devtools"

slowMo :: Option Launch Number
slowMo = opt "slowMo"

server :: Option Proxy String
server = opt "server"

bypass :: Option Proxy String
bypass = opt "bypass"

username :: Option Proxy String
username = opt "username"

password :: Option Proxy String
password = opt "password"

foreign import data Newpage :: Type

foreign import data Screenshot :: Type

path :: Option Screenshot String
path = opt "path"

screenshotType :: Option Screenshot ScreenshotType
screenshotType = opt "type"

quality :: Option Screenshot Number
quality = opt "quality"

omitBackground :: Option Screenshot Boolean
omitBackground = opt "omitBackground"

screenshotTimeout :: Option Screenshot Number
screenshotTimeout = opt "timeout"
