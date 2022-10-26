# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Faker

alias TimeManager.Repo
alias TimeManager.Accounts.User
alias TimeManager.Clock.Clocks
alias TimeManager.WorkingTimes.WorkingTime
alias Faker.Internet

Faker.start()
# Create a user
for _ <- 1..100 do
  user = %User{
    email: Faker.Internet.email(),
    username: Faker.Internet.user_name()
  }

  user = Repo.insert!(user)

  # Create a clock
  clock = %Clocks{
    user: user.id,
    time: Faker.DateTime.forward(0),
    status: Faker.Boolean.boolean()
  }

  Repo.insert!(clock)

  # Create a working time
  working_time = %WorkingTime{
    user: user.id,
    start: Faker.DateTime.forward(0),
    end: Faker.DateTime.forward(0)
  }

  Repo.insert!(working_time)
end

