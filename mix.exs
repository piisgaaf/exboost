defmodule Exboost.MixProject do
  use Mix.Project

  def project do
    [
      app: :exboost,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      compilers: [:make, :elixir, :app], # Add the make compiler
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
##      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:boost,
        git: "https://github.com/boostorg/boost.git",
        tag: "boost-1.67.0",
        submodules: true,
        compile: "./bootstrap.sh --with-libraries=math; ./b2 headers; ./b2 link=static runtime-link=static threading=single stage",
        app: false}
    ]
  end

end

defmodule Mix.Tasks.Compile.Make do
  use Mix.Task.Compiler

  @shortdoc "Compiles with make"

  def run(_) do
    {result, _error_code} = System.cmd("make", ["priv/libboostnif.so"], stderr_to_stdout: true)
    Mix.shell.info result
  end
end
