# dotfiles

## Linking

To link files to the config directory, there is a bash script `create-symlink.sh` that will link all config files to that directory.

### Usage:

```bash
chmod +x create-symlink.sh
./create-symlink.sh <config_folder_path>
```

### Example:

> .config -> /Users/<username>/.config
> dotfiles -> /Users/<username>/dotfiles

```bash
./create-symlink.sh ../config
```
