package model

// Endpoint identifies a path endpoint in the range 0 through 7.
// Positions are numbered clockwise in the tile's reference orientation:
//
//	     0     1
//	  +-----------+
//	7 |           | 2
//	6 |           | 3
//	  +-----------+
//	     5     4
type Endpoint uint8

// Tile describes a tile in its reference orientation.
// Connections[i] is the endpoint connected to endpoint i.
// The array expresses the endpoint mapping already chosen for this project;
// it contains no drawing geometry.
// A zero-value Tile is not a valid playable tile. Validation is an exercise.
type Tile struct {
	ID          string      `json:"id"`
	Connections [8]Endpoint `json:"connections"`
}

// TODO: Define valid-tile invariants and implement validation.
// TODO: Model a placed tile's orientation and implement rotation.
