# Development progression

Work through one milestone at a time. The scaffold implements only the tile
representation already agreed upon. Other model files reserve a place for
decisions rather than supplying completed models or algorithms.

1. **Tiles:** define validity, write meaningful tests, then model rotation.
   Start in `internal/model/tile.go`.
2. **Catalog:** transcribe and review the photos, then implement loading and
   validation in `internal/catalog`.
3. **Board and players:** choose coordinates, placement orientation, and piece
   positions in the separate model files. Support 1–8 players.
4. **Movement:** implement traversal in `internal/game/movement.go` against
   small arrangements whose outcomes you can verify manually.
5. **Rules and turns:** implement placement legality and progression. Include
   the forced-exit exception and document the single-player extension.
6. **Playable interface:** expand `cmd/ryro` first, then add a web interface
   when the models and rules are stable enough to use.
7. **Analysis:** define one precise objective and build a small reference
   experiment before exploring Dijkstra's, A*, or other algorithms.

Put tests beside the behavior they exercise in `*_test.go` files as each
milestone is implemented. No behavior tests exist in the initial scaffold.

Dependency direction: interfaces and analysis use the game rules and models;
the models do not depend on either. Catalog loading produces model data.
Keep rendering geometry separate from the movement representation.

For guided work, use questions, reviews, and progressively stronger hints.
Implement a complete learning exercise only when explicitly requested.
