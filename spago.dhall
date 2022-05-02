{ name = "playwright"
, dependencies =
  [ "argonaut-core"
  , "console"
  , "effect"
  , "prelude"
  , "psci-support"
  , "aff-promise"
  , "untagged-union"
  , "node-buffer"
  , "node-fs-aff"
  , "aff"
  , "either"
  , "exceptions"
  , "foreign"
  , "foreign-object"
  , "literals"
  , "maybe"
  , "node-streams"
  , "ordered-collections"
  , "refs"
  , "strings"
  , "transformers"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
