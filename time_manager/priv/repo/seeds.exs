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
alias TimeManager.Clock
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

  working_time_number = :random.uniform(30)

  for i <- 0..working_time_number do
    IO.puts("Simulation clocking action #{i} for user #{user.id}")
    lastClock = Clock.get_last_clocks_by_user_id(user.id)
    now_time = Faker.DateTime.forward(0)

    cond do

      lastClock == nil or (lastClock != nil and lastClock.status == false) ->
        Clock.do_clocks_by_user_id(user.id, true, nil, now_time)

      lastClock != nil and lastClock.status == true ->
        Clock.do_clocks_by_user_id(user.id, false, lastClock, now_time)
    end

  end

end

