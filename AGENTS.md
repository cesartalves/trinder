# AGENTS.md — Agent instructions for this repository

Purpose
-------
This file gives concise, actionable guidance for AI coding agents working on this Rails app. It links to existing docs where appropriate and highlights project conventions that are not obvious from standard Rails projects.

Where to read first
-------------------
- README: See [README.md](README.md) for full environment/setup and high-level project goals.

Quick commands
--------------
- Install gems: `bundle install`
- Set up DB (development): `bin/rails db:setup`
- Run migrations: `bin/rails db:migrate`
- Start Rails server: `bin/rails server` (or `bin/rails s`)
- Run test suite: `bin/rails test`
- Run RuboCop: `bundle exec rubocop`
- Security scan: `bin/brakeman` (project includes a Brakeman wrapper)

Key locations and conventions
-----------------------------
- App code: [app/](app/)
  - MVC: `app/controllers`, `app/models`, `app/views`
  - Stimulus controllers and frontend: `app/javascript/` (uses importmap/Stimulus)
  - Active Storage for photos: `app/models/photo.rb` and `app/controllers/photos` (see `app/models/photo.rb`)
- Authentication: Devise is used — see `config/initializers/devise.rb` and migrations for `users`.
- Matching logic: `app/models/potential_match.rb`, `app/controllers/potential_matches_controller.rb`, `app/views/potential_matches/` are primary places to modify match logic and UI.
- Tests: `test/` (unit, functional, system). Use `bin/rails test` to run.
- Database migrations: `db/migrate/` and `db/schema.rb`.
- Docker: `Dockerfile` and `docker-compose.yml` exist for containerized development.

Agent behavior guidelines
-------------------------
- Minimal edits: Prefer small, focused changes and open a short explanation for larger refactors.
- Link, don't paste: When documentation already exists (README, migrations, or other docs), link to it rather than copying content.
- Tests first: Add or update tests when changing behavior; run `bin/rails test` locally.
- Ask before infra changes: For changes to CI, Docker, or credentials, request confirmation.

Relevant files to inspect quickly
-------------------------------
- [app/models/potential_match.rb](app/models/potential_match.rb)
- [app/controllers/potential_matches_controller.rb](app/controllers/potential_matches_controller.rb)
- [app/views/potential_matches/index.html.erb](app/views/potential_matches/index.html.erb)
- [config/routes.rb](config/routes.rb)

If you add more agent-facing customizations
-----------------------------------------
If this repo needs more granular agent behaviors (e.g., frontend-only, devops, or testing hooks), create additional files named `AGENTS.frontend.md`, `AGENTS.devops.md`, etc., and link them from here.

Contact / Feedback
------------------
If anything in this file is unclear or missing, please open an issue or ask for clarification in the repo.
