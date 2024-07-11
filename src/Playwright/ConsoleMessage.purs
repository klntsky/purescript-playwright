module Playwright.ConsoleMessage where

import Prelude
import Playwright.Data (ConsoleMessage, JSHandle, URL)
import Effect (Effect)
import Playwright.Internal (effCall)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Data.String.Common (toLower)

type ConsoleMessageLocation =
  { url :: URL
  , lineNumber :: Int
  , columnNumber :: Int
  }

data ConsoleMessageType
  = Log
  | Debug
  | Info
  | Error
  | Warning
  | Dir
  | Dirxml
  | Table
  | Trace
  | Clear
  | StartGroup
  | StartGroupCollapsed
  | EndGroup
  | Assert
  | Profile
  | ProfileEnd
  | Count
  | TimeEnd

derive instance genericConsoleMessageType :: Generic ConsoleMessageType _
derive instance eqConsoleMessageType :: Eq ConsoleMessageType

instance showConsoleMessageType :: Show ConsoleMessageType where
  show = toLower <<< genericShow

args :: ConsoleMessage -> Effect (Array JSHandle)
args = effCall "args" \_ -> args

location :: ConsoleMessage -> Effect (ConsoleMessageLocation)
location = effCall "location" \_ -> location

text :: ConsoleMessage -> Effect String
text = effCall "text" \_ -> text

type' :: ConsoleMessage -> Effect ConsoleMessageType
type' = map convert <<< type''
  where
  type'' :: ConsoleMessage -> Effect String
  type'' = effCall "type" \_ -> type''
  convert = case _ of
    "log" -> Log
    "debug" -> Debug
    "info" -> Info
    "error" -> Error
    "warning" -> Warning
    "dir" -> Dir
    "dirxml" -> Dirxml
    "table" -> Table
    "trace" -> Trace
    "clear" -> Clear
    "startGroup" -> StartGroup
    "startGroupCollapsed" -> StartGroupCollapsed
    "endGroup" -> EndGroup
    "assert" -> Assert
    "profile" -> Profile
    "profileEnd" -> ProfileEnd
    "count" -> Count
    "timeEnd" -> TimeEnd
    _ -> Log -- impossible
