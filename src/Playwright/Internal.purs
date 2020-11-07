module Playwright.Internal
       ( class NumberOfArgs
       , numberOfArgs
       , effCall
       , effProp
       , affCall
       )
 where

import Type.Proxy
import Prelude
import Effect
import Effect.Aff
import Control.Promise

class NumberOfArgs x where
  numberOfArgs :: Proxy x -> Int

instance numberOfArgsFunction1 :: NumberOfArgs b => NumberOfArgs (a -> b) where
  numberOfArgs _ = numberOfArgs (Proxy :: Proxy b) + 1

else instance numberOfArgsFunction0 :: NumberOfArgs a where
  numberOfArgs _ = 0

countArgs :: forall a. NumberOfArgs a => (forall x. x -> a) -> Int
countArgs f = numberOfArgs (proxyOf f) - 2
  where
    proxyOf :: forall a. a -> Proxy a
    proxyOf _ = Proxy :: Proxy a

foreign import unsafeEffCall
  :: forall r
  .  String
  -> Int
  -> r

foreign import unsafeAffCall
  :: forall r
  .  (forall a. Effect (Promise a) -> Aff a)
  -> String
  -> Int
  -> r

effCall :: forall f. NumberOfArgs f => String -> (forall x. x -> f) -> f
effCall p f = unsafeEffCall p (countArgs f)

affCall :: forall f. NumberOfArgs f => String -> (forall x. x -> f) -> f
affCall prop f = unsafeAffCall toAffE prop (countArgs f)

foreign import effProp :: forall obj r. String -> obj -> Effect r
