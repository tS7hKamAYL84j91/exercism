defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank(), do: fn -> 0 end |> Agent.start_link |> elem(1)

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account), do: account |> Agent.stop

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account), do: account |> process_request(fn acc -> Agent.get(acc, &(&1)) end)

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount), do: account |> process_request(fn acc -> Agent.update(acc, &(&1 + amount)) end)
  
  defp process_request(account, agent_fn), do: account |> process_request(agent_fn, Process.alive?(account))
  defp process_request(account, agent_fn, true), do: account |> agent_fn.()
  defp process_request(_, _, false), do: {:error, :account_closed}
    
end
