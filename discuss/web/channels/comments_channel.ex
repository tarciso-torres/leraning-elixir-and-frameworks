defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel
    alias Discuss.{ Topic, Comment }

    def join("comments:" <> topic_id, _params, socket) do
        topic_id = String.to_integer(topic_id)
        topic = Repo.get(Topic, topic_id)

        {:ok, %{}, assign(socket, :topic, topic}
    end

    def handle_in(name, %{"content" => content}, sockect) do
        topic = sockect.assigns.topic

        changeset = topic
        |> build_assoc(:comments)
        |> Comment.changeset(%{content: content})

        case Repo.insert(changeset) do
            {:ok, comment} ->
                {:reply, :ok, sockect}
            {:error, _reason} ->
                {:reply, {:error, %{error: changeset}}, sockect}
        end
    end
end