defmodule PhoenixCounterWeb.CounterTest do
  use PhoenixCounterWeb.ConnCase
  import Phoenix.LiveViewTest

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Counter: 0"
  end

  test "Increment", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Counter: 0"
    assert render_click(view, :inc) =~ "Counter: 1"
  end

  test "Decrement", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Counter: 0"
    assert render_click(view, :dec) =~ "Counter: -1"
  end

  test "handle_info/2 Count Update", %{conn: conn} do
    {:ok, view, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Counter: 0"
    assert render(view) =~ "Counter: 0"
    send(view.pid, {:count, 2})
    assert render(view) =~ "Counter: 2"
  end

  test "handle_info/2 Presence Update - Joiner", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Connected Clients: 1"
    send(view.pid, %{
      event: "presence_diff",
      payload: %{joins: %{"phx-Fhb_dqdqsOCzKQAl" => %{metas: [%{phx_ref: "Fhb_dqdrwlCmfABl"}]}},
                  leaves: %{}}})
    assert render(view) =~ "Connected Clients: 2"
  end

  test "handle_info/2 Presence Update - Leaver", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Connected Clients: 1"
    send(view.pid, %{
      event: "presence_diff",
      payload: %{joins: %{},
                  leaves: %{"phx-Fhb_dqdqsOCzKQAl" => %{metas: [%{phx_ref: "Fhb_dqdrwlCmfABl"}]}}}})
    assert render(view) =~ "Connected Clients: 0"
  end

end
