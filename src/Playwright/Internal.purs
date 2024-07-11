module Playwright.Internal
  ( class NumberOfArgs
  , numberOfArgs
  , effCall
  , effProp
  , affCall
  ) where

import Type.Proxy (Proxy(..))
import Prelude ((+), (-))
import Effect (Effect)
import Effect.Aff (Aff)
import Control.Promise (Promise, toAffE)

class NumberOfArgs :: forall k. k -> Constraint
class NumberOfArgs x where
  numberOfArgs :: Proxy x -> Int

instance numberOfArgsFunction1 :: NumberOfArgs b => NumberOfArgs (a -> b) where
  numberOfArgs _ = numberOfArgs (Proxy :: Proxy b) + 1

else instance numberOfArgsFunction0 :: NumberOfArgs a where
  numberOfArgs _ = 0

countArgs :: forall a. NumberOfArgs a => (forall x. x -> a) -> Int
countArgs f = numberOfArgs (proxyOf f) - 2
  where
  proxyOf :: forall b. b -> Proxy b
  proxyOf _ = Proxy :: Proxy b

foreign import unsafeEffCall
  :: forall r
   . String
  -> Int
  -> r

foreign import unsafeAffCall
  :: forall r
   . (forall a. Effect (Promise a) -> Aff a)
  -> String
  -> Int
  -> r

effCall :: forall f. NumberOfArgs f => String -> (forall x. x -> f) -> f
effCall p f = unsafeEffCall p (countArgs f)

affCall :: forall f. NumberOfArgs f => String -> (forall x. x -> f) -> f
affCall prop f = unsafeAffCall toAffE prop (countArgs f)

foreign import effProp :: forall obj r. String -> obj -> Effect r
