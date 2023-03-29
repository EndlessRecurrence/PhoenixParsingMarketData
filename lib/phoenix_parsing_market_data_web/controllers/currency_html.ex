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
                <.link navigate={"/currencies/show/#{item.id}"}> <%= item.name %> </.link>
                <.link navigate={~p"/currencies/#{item.id}/edit"}>
                  <button style="margin-left: 10px; float:right;" class="bg-gray-900 hover:bg-blue-900 text-white font-bold py-2 px-4 rounded-full">
                    Edit
                  </button>
                </.link>
                <.link href={~p"/currencies/#{item.id}"} method="delete" data-confirm="Are you sure?">
                  <button style="margin-left: 20px; float:right;" class="bg-gray-900 hover:bg-blue-900 text-white font-bold py-2 px-4 rounded-full">
                    Delete
                  </button>
                </.link>
                <div style="float: right;"> <%= item.description %> </div>
              </div>
            </dt>
        </div>
      </dl>
    </div>
    """
  end
end
