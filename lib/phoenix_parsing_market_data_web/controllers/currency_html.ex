defmodule PhoenixParsingMarketDataWeb.CurrencyHTML do
  use PhoenixParsingMarketDataWeb, :html

  embed_templates "currency_html/*"

  @doc """
  Renders a currency form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def currency_form(assigns)

  def currency_list(assigns) do
    ~H"""
    <div class="mt-14">
      <dl class="-my-4 divide-y divide-zinc-100">
        <div :for={item <- @item} class="flex gap-4 py-4 sm:gap-8">
            <dt class="w-5/6 flex-none text-[0.8125rem] leading-6 text-zinc-500">
              <div>
                <.link
                  href={"/currencies/show/" <> Integer.to_string(item.id)}>
                    <%= item.name %>
                    <div style="float: right;"> <%= item.description %> </div>
                  </.link>
              </div>
            </dt>
        </div>
      </dl>
    </div>
    """
  end
end
