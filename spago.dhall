{ name = "playwright"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "argonaut-core"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "foreign"
  , "foreign-object"
  , "literals"
  , "maybe"
  , "node-buffer"
  , "node-fs-aff"
  , "node-streams"
  , "ordered-collections"
  , "prelude"
  , "psci-support"
  , "refs"
  , "strings"
  , "test-unit"
  , "transformers"
  , "undefined"
  , "untagged-union"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
