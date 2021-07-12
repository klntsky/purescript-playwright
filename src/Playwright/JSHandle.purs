module Playwright.JSHandle where

import Playwright.Data (ElementHandle, JSHandle)
import Effect (Effect)
import Untagged.Union (type (|+|))
import Literals.Null (Null)
import Playwright.Internal (affCall)
import Effect.Aff (Aff)
import Prelude
import Data.Map (Map)
import Data.Map as Map
import Control.Promise (Promise, toAffE)
import Data.Argonaut.Core (Json)

asElement :: JSHandle -> Effect (Null |+| ElementHandle)
asElement = affCall "asElement" \_ -> asElement

dispose :: JSHandle -> Aff Unit
dispose = affCall "dispose" \_ -> dispose

getProperties :: JSHandle -> Aff (Map String JSHandle)
getProperties = toAffE <<< getProperties_ Map.insert Map.empty

getProperty :: JSHandle -> Aff JSHandle
getProperty = affCall "getProperty" \_ -> getProperty

jsonValue :: JSHandle -> Aff Json
jsonValue = affCall "jsonValue" \_ -> jsonValue

foreign import getProperties_
  :: (String -> JSHandle -> Map String JSHandle -> Map String JSHandle)
  -> (Map String JSHandle)
  -> JSHandle
  -> Effect (Promise (Map String JSHandle))
