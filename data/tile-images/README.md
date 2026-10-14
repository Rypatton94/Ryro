# Tile reference images

Place your reference photos here, named `piece 0.HEIC`, `piece 1.HEIC`, etc.
Keep the original extension. Each basename matches a tile ID in `../tiles.json`:
`piece 0.HEIC` corresponds to the ID `piece 0`.

From the repository root, after copying your IMG_* photos into this folder:

```sh
# Preview the mapping first.
bash scripts/rename-tile-images.sh data/tile-images

# Apply the displayed mapping.
bash scripts/rename-tile-images.sh --apply data/tile-images
```

The script uses filename order, starts at zero, and handles common image
extensions, including HEIC, JPG, and PNG. It matches IMG_* without regard to
case, skips subfolders and symlinks, and preserves extension spelling.
It neither converts images nor changes their orientation or contents.

`rename-manifest.csv` records the original filenames and their assigned names.
Keep it with the photos to retain the source mapping. Existing destination
files or an existing manifest prevent applying a new batch. Use a folder
containing your complete batch so numbering is assigned once and remains stable.

Renaming photos does not populate the connections in `tiles.json`; those are
transcribed and reviewed separately. No photos are included in the scaffold.
