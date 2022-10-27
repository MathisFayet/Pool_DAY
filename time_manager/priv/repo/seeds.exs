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

alias TimeManager.Repo
alias TimeManager.Accounts.User
alias TimeManager.Clock.Clocks
alias TimeManager.WorkingTimes.WorkingTime

Faker.start()
# Create a user

Repo.delete_all(WorkingTime)
Repo.delete_all(Clocks)
Repo.delete_all(User)
for _ <- 1..10 do
  user = %User{
    email: Faker.Internet.email(),
    username: Faker.Internet.user_name()
  }

  user = Repo.insert!(user)

  # Create a clock
  clock = %Clocks{
    user: user,
    time: Faker.DateTime.forward(0),
    status: :rand.uniform(2) == 1
  }

  Repo.insert!(clock)

  working_time_number = :random.uniform(15)

  for i <- 0..working_time_number do
    IO.puts("Creating working time #{i} for user #{user.id}")

    start_date = Faker.DateTime.backward(365)
    end_date = start_date |> DateTime.add(24*60*60, :second)
    end_date = Faker.DateTime.between(start_date, end_date)

    working_time = %WorkingTime{
      user: user,
      start: start_date,
      end: end_date,
    }

    Repo.insert!(working_time)
  end

end

