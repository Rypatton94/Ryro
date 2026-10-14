# Ryro

A Go application for playing Tsuro with 1–8 players and exploring paths,
loops, and other patterns through independently developed analysis algorithms.

## Current status

This is a buildable project scaffold. The agreed tile endpoint representation
is defined; board/player models, rotation, movement, rules, catalog loading,
analysis, and a gameplay interface remain learning exercises.
The CLI reports this status. It does not run a game yet.

## Structure

```text
cmd/ryro/          Command-line entry point
internal/model/   Separate tile, board, player, and game-state files
internal/catalog/ Tile-data loading and validation exercise
internal/game/    Movement, placement rules, and turn exercises
internal/analysis/ Algorithm experiments
data/             Human-readable tile catalog (currently empty)
docs/             Development progression
web/              Future frontend
```

## Development

Requires Go 1.27.2 or newer. There are no external dependencies.

In the prepared cloud environment, activate the programming toolchain first:

```sh
export PATH=/workspace/ryro-tools/go/bin:$PATH
export GOPATH=/workspace/ryro-cache/go
export GOCACHE=/workspace/ryro-cache/go-build
export GOMODCACHE=/workspace/ryro-cache/go-mod
cd /workspace/Ryro
```

From the repository root:

```sh
go run ./cmd/ryro
go build ./...
go vet ./...
go test ./...
```

There are no tests yet; `go test` currently checks package compilation only.
Add meaningful tests alongside each implemented behavior.

See [the progression guide](docs/progression.md) for the milestones and
[the catalog notes](data/README.md) for the photo-transcription convention.
