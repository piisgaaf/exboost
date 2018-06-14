defmodule Exboost.MixProject do
  # Copyright [2018] Pieter Rijken
  #
  # Licensed under the Apache License, Version 2.0 (the "License");
  # you may not use this file except in compliance with the License.
  # You may obtain a copy of the License at
  #
  #     http://www.apache.org/licenses/LICENSE-2.0
  #
  # Unless required by applicable law or agreed to in writing, software
  # distributed under the License is distributed on an "AS IS" BASIS,
  # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  # See the License for the specific language governing permissions and
  # limitations under the License.

  use Mix.Project

  def project do
    [
      app: :exboost,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      compilers: [:make, :elixir, :app], # Add the make compiler
      deps: deps(),
      ## Hex stuff:
      description: description(),
      package: package(),
      name: "ExBoost",
      source_url: "https://github.com/piisgaaf/exboost"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:boost,
        git: "https://github.com/boostorg/boost.git",
        tag: "boost-1.67.0",
        submodules: true,
        compile: "./bootstrap.sh --with-libraries=math; ./b2 headers; ./b2 link=static runtime-link=static threading=single stage",
        app: false}
    ]
  end

  # Hex Package Manager stuff:
  defp description() do
    """
    Provides functions for fast matrix inversion, creation of empirical CDF from sample data including
    handling of asymmetric errors, and fitting to a funtion using chi-squared. The fitting procedure return
    the full covariance matrix describing the fitted parameters.
    """
  end
  
  defp package() do
    [
      maintainers: [ "Pieter Rijken" ],
      licenses: [ "Apache 2.0" ],
      files: [ "lib", "mix.exs", "README*", "LICENSE*", "NOTICE*" ],
      links: %{ "GitHub" => "https://github.com/piisgaaf/exboost" }
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
