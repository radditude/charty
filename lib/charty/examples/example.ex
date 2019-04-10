defmodule Charty.Examples.Example do
  use Ecto.Schema
  import Ecto.Changeset

  schema "examples" do
    field :has_good_name, :boolean, default: false
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(example, attrs) do
    example
    |> cast(attrs, [:name, :type, :has_good_name])
    |> validate_required([:name, :type, :has_good_name])
  end
end
