#!/usr/bin/env bash

echo "Loading Godot"

export GODOT="/home/patrick/.config/godotenv/godot/bin/godot"

export PATH="/home/patrick/.config/godotenv/godot/bin:$PATH"
. "$HOME/.config/godotenv/env" # Added by GodotEnv
