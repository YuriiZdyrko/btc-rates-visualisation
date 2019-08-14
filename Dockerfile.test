# Alias this container as builder:
FROM bitwalker/alpine-elixir-phoenix as builder

WORKDIR /rates

ENV MIX_ENV=test

# Umbrella
# Copy mix files so we use distillery:
COPY mix.exs mix.lock ./
COPY config config

COPY apps apps

RUN mix do deps.get, deps.compile \
  && mix test --cover
