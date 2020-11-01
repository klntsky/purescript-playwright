module Playwright.Response where

import Playwright.Data
import Playwright.Internal
import Effect.Aff (Aff)
import Node.Buffer (Buffer)
import Effect.Exception (Error)
import Effect (Effect)
import Untagged.Union
import Literals.Null

body :: Response -> Aff Buffer
body = affCall "body" typeInfo
  where typeInfo _ = body

finished :: Response -> Aff (Null |+| Error)
finished = affCall "finished" typeInfo
  where typeInfo _ = finished

frame :: Response -> Effect Frame
frame = effCall "frame" typeInfo
  where typeInfo _ = frame
