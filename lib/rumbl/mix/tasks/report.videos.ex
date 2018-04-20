defmodule Mix.Tasks.Report.Videos do
  use Mix.Task
  import Mix.Ecto
  import Ecto.Query
  alias Rumbl.Repo
  alias Rumbl.Video

  @shortdoc "Counts the number of videos"

  def run(_) do
    ensure_started(Rumbl.Repo, [])

    list =
      Repo.all(
        from(
          v in Video,
          right_join: c in assoc(v, :category),
          select: [c.name, count(v.id)],
          group_by: c.name
        )
      )

    Enum.each(list, fn a -> IO.puts("##{Enum.at(a, 0)}: #{Enum.at(a, 1)}") end)
  end
end
