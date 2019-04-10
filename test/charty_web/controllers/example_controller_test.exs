defmodule ChartyWeb.ExampleControllerTest do
  use ChartyWeb.ConnCase

  alias Charty.Examples

  @create_attrs %{has_good_name: true, name: "some name", type: "some type"}
  @update_attrs %{has_good_name: false, name: "some updated name", type: "some updated type"}
  @invalid_attrs %{has_good_name: nil, name: nil, type: nil}

  def fixture(:example) do
    {:ok, example} = Examples.create_example(@create_attrs)
    example
  end

  describe "index" do
    test "lists all examples", %{conn: conn} do
      conn = get(conn, Routes.example_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Examples"
    end
  end

  describe "new example" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.example_path(conn, :new))
      assert html_response(conn, 200) =~ "New Example"
    end
  end

  describe "create example" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.example_path(conn, :create), example: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.example_path(conn, :show, id)

      conn = get(conn, Routes.example_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Example"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.example_path(conn, :create), example: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Example"
    end
  end

  describe "edit example" do
    setup [:create_example]

    test "renders form for editing chosen example", %{conn: conn, example: example} do
      conn = get(conn, Routes.example_path(conn, :edit, example))
      assert html_response(conn, 200) =~ "Edit Example"
    end
  end

  describe "update example" do
    setup [:create_example]

    test "redirects when data is valid", %{conn: conn, example: example} do
      conn = put(conn, Routes.example_path(conn, :update, example), example: @update_attrs)
      assert redirected_to(conn) == Routes.example_path(conn, :show, example)

      conn = get(conn, Routes.example_path(conn, :show, example))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, example: example} do
      conn = put(conn, Routes.example_path(conn, :update, example), example: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Example"
    end
  end

  describe "delete example" do
    setup [:create_example]

    test "deletes chosen example", %{conn: conn, example: example} do
      conn = delete(conn, Routes.example_path(conn, :delete, example))
      assert redirected_to(conn) == Routes.example_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.example_path(conn, :show, example))
      end
    end
  end

  defp create_example(_) do
    example = fixture(:example)
    {:ok, example: example}
  end
end
