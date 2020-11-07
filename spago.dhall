{ name = "playwright"
, dependencies =
  [ "argonaut-core"
  , "console"
  , "effect"
  , "prelude"
  , "psci-support"
  , "aff-promise"
  , "test-unit"
  , "untagged-union"
  , "node-buffer"
  , "node-fs-aff"
  , "undefined"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
