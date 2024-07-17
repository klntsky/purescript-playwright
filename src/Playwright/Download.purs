module Playwright.Download
  ( createReadStream
  , suggestedFilename
  , saveAs
  , path
  , url
  , failure
  , delete
  ) where

import Control.Promise (Promise, toAffE)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Literals.Null (Null)
import Node.Stream (Readable)
import Playwright.Data (Download, URL)
import Playwright.Internal (affCall, effCall)
import Prelude
import Untagged.Union (type (|+|))

createReadStream :: Download -> Aff (Maybe (Readable ()))
createReadStream = toAffE <<< createReadStream_ Nothing Just

foreign import createReadStream_
  :: (forall a. Maybe a)
  -> (forall a. a -> Maybe a)
  -> Download
  -> Effect (Promise (Maybe (Readable ())))

suggestedFilename :: Download -> Effect String
suggestedFilename = effCall "suggestedFilename" \_ -> suggestedFilename

saveAs :: Download -> String -> Aff Unit
saveAs = affCall "saveAs" \_ -> saveAs

path :: Download -> Effect (Null |+| String)
path = effCall "path" \_ -> path

url :: Download -> Effect URL
url = effCall "url" \_ -> url

failure :: Download -> Aff (Null |+| String)
failure = affCall "failure" \_ -> failure

delete :: Download -> Aff Unit
delete = affCall "delete" \_ -> delete
