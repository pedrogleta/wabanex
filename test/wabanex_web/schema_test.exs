defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user queries" do
    test "when valid id given return user", %{conn: conn} do
      params = %{email: "johndoe@wabanex.com", name: "John Doe", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          name
          email
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "johndoe@wabanex.com",
            "name" => "John Doe"
          }
        }
      }

      assert expected_response == response
    end
  end
end
