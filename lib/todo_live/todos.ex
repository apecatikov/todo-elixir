defmodule TodoLive.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias TodoLive.Repo

  alias TodoLive.Todos.Todo

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(TodoLive.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(TodoLive.PubSub, @topic, {__MODULE__, event, result})
  end

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos do
    Repo.all(Todo)
  end

  @doc """
  Gets a single todo.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}) do
    case Todo.changeset(%Todo{}, attrs)|> Repo.insert() do
      {:ok, todo} = result ->
        broadcast_change(result, [:todo, :created])
        {:ok, todo}

      {:error, changeset} ->
        # add error handling
        {:error, changeset}
    end

  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs) do
    case Todo.changeset(todo, attrs) |> Repo.update() do
      {:ok, todo} = result ->
        broadcast_change(result, [:todo, :updated])
        {:ok, todo}

      {:error, changeset} ->
        #add error handling
       {:error, changeset}
    end
  end

  @doc """
  Deletes a todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo) do
    case Repo.delete(todo) do
      {:ok, todo} = result ->
        broadcast_change(result, [:todo, :deleted])
        {:ok, todo}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end
end
