defmodule PhoenixParsingMarketDataWeb.CurrencyControllerTest do
  use PhoenixParsingMarketDataWeb.ConnCase

  import PhoenixParsingMarketData.CurrencyContextFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all currencies", %{conn: conn} do
      conn = get(conn, ~p"/currencies")
      assert html_response(conn, 200) =~ "Listing Currencies"
    end
  end

  describe "new currency" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/currencies/new")
      assert html_response(conn, 200) =~ "New Currency"
    end
  end

  describe "create currency" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/currencies", currency: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/currencies/#{id}"

      conn = get(conn, ~p"/currencies/#{id}")
      assert html_response(conn, 200) =~ "Currency #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/currencies", currency: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Currency"
    end
  end

  describe "edit currency" do
    setup [:create_currency]

    test "renders form for editing chosen currency", %{conn: conn, currency: currency} do
      conn = get(conn, ~p"/currencies/#{currency}/edit")
      assert html_response(conn, 200) =~ "Edit Currency"
    end
  end

  describe "update currency" do
    setup [:create_currency]

    test "redirects when data is valid", %{conn: conn, currency: currency} do
      conn = put(conn, ~p"/currencies/#{currency}", currency: @update_attrs)
      assert redirected_to(conn) == ~p"/currencies/#{currency}"

      conn = get(conn, ~p"/currencies/#{currency}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = put(conn, ~p"/currencies/#{currency}", currency: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Currency"
    end
  end

  describe "delete currency" do
    setup [:create_currency]

    test "deletes chosen currency", %{conn: conn, currency: currency} do
      conn = delete(conn, ~p"/currencies/#{currency}")
      assert redirected_to(conn) == ~p"/currencies"

      assert_error_sent 404, fn ->
        get(conn, ~p"/currencies/#{currency}")
      end
    end
  end

  defp create_currency(_) do
    currency = currency_fixture()
    %{currency: currency}
  end
end
