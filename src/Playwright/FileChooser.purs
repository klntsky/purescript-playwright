module Playwright.FileChooser where

import Effect (Effect)
import Effect.Aff (Aff)
import Node.Buffer (Buffer)
import Playwright.Data (ElementHandle, FileChooser, Page)
import Playwright.Internal (affCall, effCall)
import Playwright.Options (SetFilesOptions)
import Prelude
import Untagged.Castable (class Castable)
import Untagged.Union (type (|+|))

element :: FileChooser -> Effect ElementHandle
element = effCall "element" \_ -> element

isMultiple :: FileChooser -> Effect Boolean
isMultiple = effCall "isMultiple" \_ -> isMultiple

page :: FileChooser -> Effect Page
page = effCall "page" \_ -> page

setFiles
  :: forall o f
   . Castable o SetFilesOptions
  => Castable f
       ( String
           |+| Array String
           |+|
             { name :: String
             , mimeType :: String
             , buffer :: Buffer
             }
           |+| Array
             { name :: String
             , mimeType :: String
             , buffer :: Buffer
             }
       )
  => FileChooser
  -> f
  -> o
  -> Aff Unit
setFiles = affCall "setFiles" \_ -> setFiles
