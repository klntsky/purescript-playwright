module Playwright.Response
  ( body
  , finished
  , frame
  , headers
  , json
  , ok
  , request
  , status
  , statusText
  , text
  , url
  ) where

import Control.Promise (Promise, toAffE)
import Data.Argonaut.Core (Json)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Exception (Error)
import Foreign.Object (Object)
import Node.Buffer (Buffer)
import Playwright.Data (Frame, Request, Response)
import Playwright.Internal (affCall, effCall)
import Prelude

body :: Response -> Aff Buffer
body = affCall "body" \_ -> body

finished :: Response -> Aff (Maybe Error)
finished = toAffE <<< finished_ Nothing Just

foreign import finished_
  :: (forall a. Maybe a)
  -> (forall a. a -> Maybe a)
  -> Response
  -> Effect (Promise (Maybe Error))

frame :: Response -> Effect Frame
frame = effCall "frame" \_ -> frame

headers :: Response -> Effect (Object String)
headers = effCall "headers" \_ -> headers

json :: Response -> Aff Json
json = affCall "json" \_ -> json

ok :: Response -> Effect Boolean
ok = effCall "ok" \_ -> ok

request :: Response -> Effect Request
request = effCall "request" \_ -> request

status :: Response -> Effect Int
status = effCall "status" \_ -> status

statusText :: Response -> Effect String
statusText = effCall "statusText" \_ -> statusText

text :: Response -> Aff String
text = affCall "text" \_ -> text

url :: Response -> Effect String
url = effCall "url" \_ -> url
