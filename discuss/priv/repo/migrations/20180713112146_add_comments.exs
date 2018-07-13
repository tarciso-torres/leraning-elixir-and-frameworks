defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :conmment, :string
      add :user_id, references(:user)
      add :topic_id, references(:topics)

      timestamps()
    end
  end
end
