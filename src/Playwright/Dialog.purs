module Playwright.Dialog where

import Prelude
import Playwright.Internal (affCall, effCall)
import Playwright.Data (Dialog)
import Effect (Effect)
import Effect.Aff (Aff)

accept :: Dialog -> String -> Aff Unit
accept = affCall "accept" \_ -> accept

defaultValue :: Dialog -> Effect String
defaultValue = effCall "defaultValue" \_ -> defaultValue

dismiss :: Dialog -> Aff Unit
dismiss = affCall "dismiss" \_ -> dismiss

message :: Dialog -> Effect String
message = effCall "message" \_ -> message

data DialogType = Alert | Beforeunload | Confirm | Prompt

type' :: Dialog -> Effect DialogType
type' = map convert <<< type''
  where
  type'' = effCall "type" \_ -> type''
  convert = case _ of
    "alert" -> Alert
    "beforeunload" -> Beforeunload
    "confirm" -> Confirm
    "prompt" -> Prompt
    _ -> Alert -- impossible
