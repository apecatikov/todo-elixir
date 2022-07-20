defmodule TodoLiveWeb.TodoLive do
  use TodoLiveWeb, :live_view
  alias TodoLive.Todos

  def mount(_params, _session, socket) do
    Todos.subscribe()

    {:ok, fetch(socket)}
  end

  def handle_event("add", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)

    {:noreply, socket}
  end

  def handle_event("check_done", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)

    Todos.update_todo(todo, %{"done" => !todo.done})

    {:noreply, socket}
  end

  def handle_event("clear_todos", _params, socket) do
    Todos.list_todos()
    |> Enum.filter(fn todo -> todo.done end)
    |> Enum.each(fn todo -> Todos.delete_todo(todo) end)

    {:noreply, socket}
  end

  def handle_info({Todos, [:todo | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket,  todos: Todos.list_todos())
  end
end
