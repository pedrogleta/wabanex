defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid then return valid changeset" do
      params = %{name: "John Doe", email: "johndoe@wabanex.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "johndoe@wabanex.com", name: "John Doe", password: "123456"},
               errors: []
             } = response
    end

    test "when some params are invalid then return invalid changeset" do
      params = %{email: "johndoe@wabanex.com", password: "12345"}

      response = User.changeset(params)

      assert errors_on(response) == %{
               name: ["can't be blank"],
               password: ["should be at least 6 character(s)"]
             }
    end
  end
end
