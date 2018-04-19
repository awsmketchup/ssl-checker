defmodule SslChecker do
	@moduledoc """
	Documentation for SslChecker.
	"""

	@doc """
	checks SSL validity of the supplied host. It takes
	the host and optional port as parameter. Port defaults to 443

	Returns a map containing results

	## Examples

	iex> SslChecker.check("github.com", 443)
	%{
		"issuer" => "DigiCert Inc",
		"notAfter" => "May 17 12:00:00 2018 GMT",
		"notBefore" => "Mar 10 00:00:00 2016 GMT",
		"subject" => "GitHub, Inc."
	}

	iex> SslChecker.check("invalid.host", 443)
	"unable to load certificate"
	"""

  def check(host, port \\ 443) do
	command = command(host, port)
	case System.cmd("/bin/sh", ["-c", command]) do
		{output, 0} ->
			output
			|> format_output
			|> output_to_map(%{})
		_ -> "unable to load certificate"
	end
  end

  defp format_output(output) do
	output
	|> String.split("\n", trim: true)
  end

  defp output_to_map([], map), do: map
  defp output_to_map([out | output], map) do
	arr = out
		|> String.replace("=", "->", global: false)
		|> String.split("->", trim: true)

	output_to_map(output,
		map
		|> Map.merge(get_key_val(arr))
	)
  end

  defp get_key_val([key, val]) when key == "subject" or key == "issuer" do
	case Regex.run(~r/O=(.*?)\//, val) do
		nil -> %{ key => "" }
		arr -> %{ key => Enum.at(arr, 1) }
	end
  end
  defp get_key_val([key, val]), do: %{ key => val }

  defp command(host, port) do
  	"echo | openssl s_client -showcerts -connect #{host}:#{port} 2>/dev/null | openssl x509 -inform pem -noout -issuer -subject -dates"
  end
end
