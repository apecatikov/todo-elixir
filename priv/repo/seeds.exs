# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodoLive.Repo.insert!(%TodoLive.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

TodoLive.Repo.insert!(%TodoLive.Todos.Todo{title: "100 push ups"})
TodoLive.Repo.insert!(%TodoLive.Todos.Todo{title: "100 sit ups"})
TodoLive.Repo.insert!(%TodoLive.Todos.Todo{title: "100 squats"})
TodoLive.Repo.insert!(%TodoLive.Todos.Todo{title: "10km run"})
TodoLive.Repo.insert!(%TodoLive.Todos.Todo{title: "eat 1 banana"})
