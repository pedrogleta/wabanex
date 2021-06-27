defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all valid params then return imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      expected_response = %{
        "Dani" => 23.437499999999996,
        "Diego" => 23.04002019946976,
        "Gabul" => 22.857142857142858,
        "Rafael" => 24.897060231734173,
        "Rodrigo" => 26.234567901234566
      }

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      assert expected_response == response
    end

    test "when some invalid params then return error", %{conn: conn} do
      params = %{"filename" => "inexistent_file.csv"}

      expected_response = "Error while opening the file"

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      assert expected_response == response
    end
  end
end
