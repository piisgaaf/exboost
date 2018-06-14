defmodule Exboost.Math do
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

  @on_load :init

  def init() do
    :ok = :erlang.load_nif("priv/libboostnif", 0)
    :ok
  end

  @doc """
  Provides the regularized lower incomplete gamma function.
  
  ## Examples

      iex> Exboost.Math.gamma_p(0.234,2.3)
      0.9891753004794075

      iex> Exboost.Math.gamma_p(5.0,0.0)
      0.0

  """
  def gamma_p(a,z), do: _gamma_p(a,z)
  def _gamma_p(_a,_z), do: "NIF library not loaded"

end
