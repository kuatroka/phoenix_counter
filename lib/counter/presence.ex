defmodule Counter.Presence do
  @moduledoc """
  Documentation for the Presence module.
  """

  use Phoenix.Presence, otp_app: :phoenix_counter,
                        pubsub_server: PhoenixCounter.PubSub
end
