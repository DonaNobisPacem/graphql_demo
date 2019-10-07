defmodule GraphqlDemoWeb.Helpers.GraphqlHelpers do
  alias Ecto.Changeset

  def format_results({:error, message}) when is_binary(message) do
    {:error, message}
  end

  def format_results({:error, %Changeset{} = changeset}) do
    messages =
      changeset
      |> Changeset.traverse_errors(fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)
      |> Enum.map(&extract_message/1)

    {:error, messages}
  end

  def format_results(result), do: result

  def stringify_keys(map), do: map |> Jason.encode!() |> Jason.decode!()

  def authenticator(args, %{context: %{current_user: _current_user}} = context, resolver),
    do: resolver.(args, context)

  def authenticator(_args, _context, _function), do: {:error, "unauthenticated"}

  defp extract_message(string) when is_binary(string), do: string

  defp extract_message({k, v}), do: humanize_string(k) <> " " <> extract_message(v)
  defp extract_message(map) when map == %{}, do: ""

  defp extract_message(map) when is_map(map) do
    map
    |> Enum.reduce("", fn {k, v}, acc ->
      acc <> " " <> humanize_string(k) <> " " <> extract_message(v)
    end)
    |> String.trim()
  end

  defp extract_message(list) when is_list(list) do
    list
    |> Enum.reduce("", fn i, acc -> acc <> " " <> extract_message(i) end)
    |> String.trim()
  end

  defp extract_message(item), do: to_string(item)

  defp humanize_string(atom) when is_atom(atom) do
    atom
    |> to_string
    |> String.capitalize()
    |> String.replace("_", " ")
  end

  defp humanize_string(resource), do: to_string(resource)
end
