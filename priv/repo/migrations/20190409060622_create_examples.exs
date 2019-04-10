defmodule Charty.Repo.Migrations.CreateExamples do
  use Ecto.Migration

  def change do
    create table(:examples) do
      add :name, :string
      add :type, :string
      add :has_good_name, :boolean, default: false, null: false

      timestamps()
    end

  end
end
