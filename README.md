# SslChecker

Check validity of SSL Certificate

## Documentation

API documentation can be found at https://hexdocs.pm/ssl_checker/0.1.0

## Installation

Add `ssl_checker` to your list of dependencies

```elixir
def deps do
  [
    {:ssl_checker, "~> 0.1.0"}
  ]
end
```

## Basics
```
iex> SslChecker.check("github.com", 443)
%{
	"issuer" => "DigiCert Inc",
	"notAfter" => "May 17 12:00:00 2018 GMT",
	"notBefore" => "Mar 10 00:00:00 2016 GMT",
	"subject" => "GitHub, Inc."
}

iex> SslChecker.check("invalid.host", 443)
"unable to load certificate"

```
