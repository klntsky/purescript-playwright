{ name = "playwright"
, dependencies =
  [ "console"
  , "effect"
  , "prelude"
  , "psci-support"
  , "aff-promise"
  , "test-unit"
  , "untagged-union"
  , "node-buffer"
  , "node-fs-aff"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
