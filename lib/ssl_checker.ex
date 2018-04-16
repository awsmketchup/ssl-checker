defmodule SslChecker do
  @moduledoc """
  Documentation for SslChecker.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SslChecker.hello
      :world

  """
  def hello do
    :world
  end

  def check(host, port \\ 443) do
	command = command(host, port)
  	{output, 0} = System.cmd("/bin/sh", ["-c", command])
	output
  end

  defp command(host, port) do
  	"echo | openssl s_client -showcerts -connect #{host}:#{port} 2>/dev/null | openssl x509 -inform pem -noout -issuer -subject -dates"
  end
end
