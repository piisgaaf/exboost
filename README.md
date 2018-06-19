# Exboost

Provides a subset of the portable BOOST library as Elixir functions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exboost` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exboost, "~> 0.1.0"}
  ]
end
```

### Boost

The package assumes that Boost is installed and the statis libraries and include files are available at BOOSTLIB and BOOSTINCLUDE

### Mix

To compile using mix, execute:

```shell
$ BOOSTLIB=<library path> BOOSTINCLUDE=<include path> mix compile
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exboost](https://hexdocs.pm/exboost).
