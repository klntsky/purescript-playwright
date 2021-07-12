let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.2-20210629/packages.dhall sha256:534c490bb73cae75adb5a39871142fd8db5c2d74c90509797a80b8bb0d5c3f7b

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
          , "psci-support"
          , "tuples"
          , "unsafe-coerce"
          ]
        , repo = "https://github.com/jvliwanag/purescript-untagged-union.git"
        , version = "v0.3.0"
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
