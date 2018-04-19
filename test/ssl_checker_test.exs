defmodule SslCheckerTest do
	use ExUnit.Case
	doctest SslChecker

	setup do
		[
  			valid_host: SslChecker.check("github.com"),
  		]
	end

	describe "when host is valid" do
		test "output should contain issuer", context do
			assert Map.has_key?(context[:valid_host], "issuer")
		end

		test "output should contain notAfter", context do
			assert Map.has_key?(context[:valid_host], "notAfter")
		end

		test "output should contain notBefore", context do
			assert Map.has_key?(context[:valid_host], "notBefore")
		end

		test "output should contain subject", context do
			assert Map.has_key?(context[:valid_host], "subject")
		end
	end

	describe "when host is not valid" do
		test "returns message when host is not valid" do
    		msg = "unable to load certificate"
    		assert SslChecker.check("invalid.host") == msg
    	end
	end
end
