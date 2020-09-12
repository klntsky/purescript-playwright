module Playwright.Logger where

import Prelude
import Effect
import Control.Promise
import Data.Options
import Effect.Aff
import Foreign
import Data.Function.Uncurried
import Data.Op
import Data.Functor.Contravariant
import Prim.Row as Row
import Unsafe.Coerce (unsafeCoerce)

-- foreign import data LoggerOptions :: Type

data Severity = Verbose | Info | Warning | Error

showSeverity :: Severity -> String
showSeverity Verbose = "verbose"
showSeverity Info = "info"
showSeverity Warning = "warning"
showSeverity Error = "error"

-- isEnabled :: Option LoggerOptions (Fn2 String Severity Boolean)
-- isEnabled = opt "isEnabled"

type LoggerOptions =
    ( log :: String -> Severity -> String -> Array String -> Effect Unit
    , isEnabled :: String -> Severity -> Boolean
    )

foreign import data Logger :: Type

mkLogger
 :: forall o t
  . Row.Union o t LoggerOptions
 => { | o }
 -> Logger
mkLogger = unsafeCoerce

-- log :: Option LoggerOptions (Fn4 String Severity String (Array String) Unit)
-- log = opt "log"
