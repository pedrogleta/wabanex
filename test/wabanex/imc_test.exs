defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when file exists then return data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Dani" => 23.437499999999996,
           "Diego" => 23.04002019946976,
           "Gabul" => 22.857142857142858,
           "Rafael" => 24.897060231734173,
           "Rodrigo" => 26.234567901234566
         }}

      assert expected_response == response
    end

    test "when file not exists then return error" do
      params = %{"filename" => "inexistent_file.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert expected_response == response
    end
  end
end
