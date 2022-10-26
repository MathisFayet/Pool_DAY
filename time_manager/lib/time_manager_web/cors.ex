defmodule TimeManagerWeb.CORS do
  use Corsica.Router,
      origins: "*",
      allow_credentials: true,
      max_age: 600,
      allow_headers: :all,
      allow_methods: :all,
      same_origins: false
  resource "/*"
end