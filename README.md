# FoodTrucks

To run this Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mix ecto.setup` to setup and seed the database
  * Run `mix test` to run the test suite
  * Run `mix ecto.setup` to setup and seed the database
  * Run `mix test` to run the test suite
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser. You should see a map with a marker for each vendor above a list of vendors, with basic CRUD functionality for the vendors exposed in LiveView.

As this was a time-limited assessment, some things I would continue to work on if this were a real project:
- Proper secrets management in environment variables (instead, this token will be revoked shortly)
- Pagination, filtering, searching on the index view
- Proper streaming of the vendors data instead of holding onto the whole collection in memory
- Possibly connect directly to the SF data source, which, with the streaming working, would allow realtime updates of the page if the data changed remotely
- Probably swap the naming of FoodTrucks and SanFranEats, they just ended up that way because SanFranEats only occurred to me after I'd already made some progress after generating the Phoenix project with the name FoodTrucks
- Polish up the frontend
- Add more tests; due to the time constraints I stuck with just making the generated tests pass, but I'd also like to test things like the after_render event handling and what should happen when the CSV has invalid data
- Use a smaller fixture CSV for tests
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser. You should see a map with a marker for each vendor above a list of vendors, with basic CRUD functionality for the vendors exposed in LiveView.

As this was a time-limited assessment, some things I would continue to work on if this were a real project:
- Proper secrets management in environment variables (instead, this token will be revoked shortly)
- Pagination, filtering, searching on the index view
- Proper streaming of the vendors data instead of holding onto the whole collection in memory
- Possibly connect directly to the SF data source, which, with the streaming working, would allow realtime updates of the page if the data changed remotely
- Probably swap the naming of FoodTrucks and SanFranEats, they just ended up that way because SanFranEats only occurred to me after I'd already made some progress after generating the Phoenix project with the name FoodTrucks
- Polish up the frontend
- Add more tests; due to the time constraints I stuck with just making the generated tests pass, but I'd also like to test things like the after_render event handling and what should happen when the CSV has invalid data
- Use a smaller fixture CSV for tests
