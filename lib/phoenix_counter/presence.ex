defmodule Counter.Presence do
  use Phoenix.Presence,
    otp_app: :phoenix_counter,
    pubsub_server: PhoenixCounter.PubSub
end
