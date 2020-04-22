defmodule Experiment.Router do
  use Plug.Router
  require Slime

  #@template_dir "lib/experiment/templates"

  plug Plug.Parsers, parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/" do
    cnt = Experiment.Status.get
    times = Experiment.Status.times
    render(conn, [cnt: cnt, times: times])
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  defmodule Render do
    @template "lib/experiment/templates/index.html.slim"
    Slime.function_from_file(:def, :index_html, @template, [:cnt, :times])
  end

  defp render(%{status: status} = conn, assigns) do
    #path = @template_dir
    #  |> Path.join(template)
    #  |> String.replace_suffix(".html", ".html.slim")

    Experiment.Status.inc

    cnt = assigns[:cnt]
    times = assigns[:times]

    send_resp(conn, (status || 200), Render.index_html(cnt, times))
  end

  defp render_json(%{status: status} = conn, data) do
    body = Jason.encode!(data)
    send_resp(conn, (status || 200), body)
  end
end
