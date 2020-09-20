let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20200911-2/packages.dhall sha256:872c06349ed9c8210be43982dc6466c2ca7c5c441129826bcb9bf3672938f16e

let overrides =
      { untagged-union =
        { dependencies =
          [ "assert"
          , "console"
          , "effect"
          , "foreign"
          , "foreign-object"
          , "literals"
          , "maybe"
          , "newtype"
          , "proxy"
          , "psci-support"
          , "tuples"
          , "unsafe-coerce"
          ]
        , repo = "https://github.com/jvliwanag/purescript-untagged-union.git"
        , version = "edc091a1fde2cb6ac775865ee6e761b2fb99fc22"
        }
      }

let additions =
      { literals =
        { dependencies =
          [ "assert"
          , "effect"
          , "console"
          , "integers"
          , "numbers"
          , "partial"
          , "psci-support"
          , "unsafe-coerce"
          , "typelevel-prelude"
          ]
        , repo = "https://github.com/jvliwanag/purescript-literals.git"
        , version = "7b2ae20f77c67b7e419a92fdd0dc7a09b447b18e"
        }
      }

in  upstream ⫽ overrides ⫽ additions
