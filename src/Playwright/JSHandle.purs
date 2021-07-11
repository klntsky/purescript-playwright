module Playwright.JSHandle where

import Prelude

import Control.Promise (Promise, toAffE)
import Data.Argonaut.Core (Json)
import Data.Map (Map, empty)
import Data.Map as Map
import Effect (Effect)
import Effect.Aff (Aff)
import Literals.Null (Null)
import Playwright.Data (ElementHandle, JSHandle)
import Playwright.Internal (affCall)
import Untagged.Union (type (|+|))

asElement :: JSHandle -> Effect (Null |+| ElementHandle)
asElement = affCall "asElement" \_ -> asElement

dispose :: JSHandle -> Aff Unit
dispose = affCall "dispose" \_ -> dispose

getProperties :: JSHandle -> Aff (Map String JSHandle)
getProperties = toAffE <<< getProperties_ Map.insert empty

getProperty :: JSHandle -> Aff JSHandle
getProperty = affCall "getProperty" \_ -> getProperty

jsonValue :: JSHandle -> Aff Json
jsonValue = affCall "jsonValue" \_ -> jsonValue

foreign import getProperties_
  :: (String -> JSHandle -> Map String JSHandle -> Map String JSHandle)
  -> (Map String JSHandle)
  -> JSHandle
  -> Effect (Promise (Map String JSHandle))
