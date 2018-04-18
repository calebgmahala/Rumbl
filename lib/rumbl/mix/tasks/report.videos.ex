defmodule Mix.Tasks.Report.Videos do
  use Mix.Task
  import Mix.Ecto
  import Ecto.Query
  alias Rumbl.Repo
  alias Rumbl.Video

  @shortdoc "Counts the number of videos"

  def run(_) do
    ensure_started(Rumbl.Repo, [])

    Repo.all(
      from(
        v in Video,
        join: c in assoc(v, :category),
        select: count(v.id)
      )
    )
    |> IO.inspect()
  end
end
