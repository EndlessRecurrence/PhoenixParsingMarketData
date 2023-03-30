defmodule PhoenixParsingMarketDataWeb.ValueHTML do
  use PhoenixParsingMarketDataWeb, :html

  embed_templates "value_html/*"

  @doc """
  Renders a value form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def value_form(assigns)

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def value_editing_button(assigns) do
    ~H"""
    <button
      type={@type}
      class={[
        "phx-submit-loading:opacity-75 rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3",
        "text-sm font-semibold leading-6 text-white active:text-white/80",
        @class
      ]}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
