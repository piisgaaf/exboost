defmodule Exboost.Math do
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
