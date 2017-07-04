defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @earth_year_in_secs 31557600               
  
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    (seconds / @earth_year_in_secs) / orbital_period(planet) 
  end

  @spec orbital_period(planet) :: float
  defp orbital_period(:mercury), do: 0.2408467
  defp orbital_period(:venus), do: 0.61519726
  defp orbital_period(:earth), do: 1.0
  defp orbital_period(:mars), do: 1.8808158
  defp orbital_period(:jupiter), do: 11.862615
  defp orbital_period(:saturn), do: 29.447498
  defp orbital_period(:uranus), do: 84.016846
  defp orbital_period(:neptune), do: 164.79132

end
