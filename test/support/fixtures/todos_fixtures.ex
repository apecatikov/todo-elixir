defmodule TodoLive.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoLive.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        done: true,
        title: "some title"
      })
      |> TodoLive.Todos.create_todo()

    todo
  end
end
