let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.0-20220429/packages.dhall
        sha256:03c682bff56fc8f9d8c495ffcc6f524cbd3c89fe04778f965265c08757de8c9d

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
        , repo = "https://github.com/working-group-purescript-es/purescript-untagged-union.git"
        , version = "es-modules"
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
    , repo = "https://github.com/working-group-purescript-es/purescript-literals.git"
    , version = "es-modules"
    }
      }


in  upstream // overrides // additions
