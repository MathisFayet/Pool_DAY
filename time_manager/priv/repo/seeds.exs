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
for _ <- 1..1 do
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

  working_time_number = :random.uniform(1)

  for i <- 0..working_time_number do
    IO.puts("Simulation clocking action #{i} for user #{user.id}")
    lastClock = Clock.get_last_clocks_by_user_id(user.id)
    nb_day_backward = :random.uniform(365)
    clockIn_time = Faker.DateTime.backward(nb_day_backward)
    IO.puts("time IN #{clockIn_time}")

    clockInHour = :random.uniform(24)
    clockIn_time = Map.put(clockIn_time, "hour", clockInHour)
#    clockOut_time = Faker.DateTime.backward(nb_day_backward)
    clockOutHour = Enum.random(clockInHour..24)
    clockOut_time = Map.put(clockIn_time, "hour", clockOutHour)
    clockOut_time = Map.put(clockIn_time, "minute", Enum.random(0..59))
    IO.puts("time OUT #{clockOut_time}")

    cond do

      lastClock == nil or (lastClock != nil and lastClock.status == false) ->
        Clock.do_clocks_by_user_id(user.id, true, nil, clockIn_time)

      lastClock != nil and lastClock.status == true ->
        Clock.do_clocks_by_user_id(user.id, false, lastClock, clockOut_time)
    end

  end

end

