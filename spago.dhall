{ name = "playwright"
, dependencies =
  [ "console"
  , "effect"
  , "prelude"
  , "psci-support"
  , "aff-promise"
  , "options"
  , "test-unit"
  , "untagged-union"
  , "node-buffer"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
