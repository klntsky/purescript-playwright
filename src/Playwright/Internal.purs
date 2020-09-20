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

-- More may be added later...
instance numberOfArgsFunction6 :: NumberOfArgs (a -> b -> c -> d -> e -> f -> g) where
  numberOfArgs _ = 6

else instance numberOfArgsFunction5 :: NumberOfArgs (a -> b -> c -> d -> e -> f) where
  numberOfArgs _ = 5

else instance numberOfArgsFunction4 :: NumberOfArgs (a -> b -> c -> d -> e) where
  numberOfArgs _ = 4

else instance numberOfArgsFunction3 :: NumberOfArgs (a -> b -> c -> d) where
  numberOfArgs _ = 3

else instance numberOfArgsFunction2 :: NumberOfArgs (a -> b -> c) where
  numberOfArgs _ = 2

else instance numberOfArgsFunction1 :: NumberOfArgs (a -> b) where
  numberOfArgs _ = 1

else instance numberOfArgsFunction0 :: NumberOfArgs a where
  numberOfArgs _ = 0

-- | This function is used to prevent "The value of x is undefined here"
-- | errors.
-- |
-- | E.g.:
-- |
-- | ```purescript
-- | url = unsafeEffectfulGetter "url" (countArgs \_ -> url)
-- | ```
-- |
-- | Thus we can guarantee type safety at least in the number of arguments.
countArgs :: forall a. NumberOfArgs a => (Unit -> a) -> Int
countArgs f = numberOfArgs (proxyOf (f unit)) - 1
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

effCall :: forall f. NumberOfArgs f => String -> (Unit -> f) -> f
effCall p f = unsafeEffCall p (countArgs f)

affCall :: forall f. NumberOfArgs f => String -> (Unit -> f) -> f
affCall prop f = unsafeAffCall toAffE prop (countArgs f)

foreign import effProp :: forall obj r. String -> obj -> Effect r
