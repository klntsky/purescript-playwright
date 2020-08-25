{ name = "playwright"
, dependencies =
  [ "console", "effect", "prelude", "psci-support", "aff-promise", "options" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
