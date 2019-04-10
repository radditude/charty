defmodule Charty.Examples do
  @moduledoc """
  The Examples context.
  """

  import Ecto.Query, warn: false
  alias Charty.Repo

  alias Charty.Examples.Example

  @doc """
  Returns the list of examples.

  ## Examples

      iex> list_examples()
      [%Example{}, ...]

  """
  def list_examples do
    Repo.all(Example)
  end

  def list_examples_by_type do
    from(
      e in Example,
      group_by: e.type,
      select: {e.type, count(e.id)}
    )
    |> Repo.all()
    |> Enum.reduce(%{}, fn {type, count}, acc ->
      Map.put(acc, type, count)
    end)
  end

  @doc """
  Gets a single example.

  Raises `Ecto.NoResultsError` if the Example does not exist.

  ## Examples

      iex> get_example!(123)
      %Example{}

      iex> get_example!(456)
      ** (Ecto.NoResultsError)

  """
  def get_example!(id), do: Repo.get!(Example, id)

  @doc """
  Creates a example.

  ## Examples

      iex> create_example(%{field: value})
      {:ok, %Example{}}

      iex> create_example(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_example(attrs \\ %{}) do
    %Example{}
    |> Example.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a example.

  ## Examples

      iex> update_example(example, %{field: new_value})
      {:ok, %Example{}}

      iex> update_example(example, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_example(%Example{} = example, attrs) do
    example
    |> Example.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Example.

  ## Examples

      iex> delete_example(example)
      {:ok, %Example{}}

      iex> delete_example(example)
      {:error, %Ecto.Changeset{}}

  """
  def delete_example(%Example{} = example) do
    Repo.delete(example)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking example changes.

  ## Examples

      iex> change_example(example)
      %Ecto.Changeset{source: %Example{}}

  """
  def change_example(%Example{} = example) do
    Example.changeset(example, %{})
  end
end
