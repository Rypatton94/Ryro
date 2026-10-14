# Tile catalog

`tiles.json` is an empty catalog awaiting transcription and review of the
uploaded photos. An empty catalog is not a playable tile set.

Each future record has an `id` and a `connections` array with eight entries.
Array index is the entry endpoint; its value is the connected endpoint.
Use the clockwise numbering documented in `internal/model/tile.go`.

Record each tile in a reference orientation and keep that orientation consistent
with its source photo. Keep tile identity distinct from its orientation in play.
The photos are reference material; this scaffold does not copy them into Git.

Before accepting records, implement and test the tile-validation exercise.
