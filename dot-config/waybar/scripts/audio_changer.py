#!/usr/bin/env python import subprocess import json
import sys
import subprocess
import json
from typing import Dict, List

MEDIA_CLASS_SINK = "Audio/Sink"
MEDIA_CLASS_SOURCE = "Audio/Source"


def get_property(node: Dict, property: str) -> str | None:
    return node.get("info", {}).get("props", {}).get(property, None)


def parse_metadata(pipewire_state: Dict):
    default_sink = None
    default_source = None
    for node in pipewire_state:
        metadata_name = node.get("props", {}).get("metadata.name", None)
        if metadata_name == "default":
            for metadata in node["metadata"]:
                match metadata["key"]:
                    case "default.audio.sink":
                        default_sink = metadata["value"]
                        break
                    case "default.audio.source":
                        default_source = metadata["value"]
                        break
    return default_sink, default_source


def parse_nodes(pipewire_state: Dict, media_class: str) -> List:
    sinks: List = []
    for node in pipewire_state:
        mediaClass = get_property(node, "media.class")
        if mediaClass is not None and mediaClass == media_class:
            sinks.append(node)
    return sinks


def get_pw_dump() -> Dict:
    pw_dump_output = subprocess.check_output(["pw-dump", "-N"])
    return json.loads(pw_dump_output)


def get_wofi_options(nodes: List, default_name: str) -> str:
    options = ""
    for node in nodes:
        node_description = get_property(node, "node.description")
        node_name = get_property(node, "node.name")
        options += f"{'' if node_name == default_name else ''}{node_description}\n"
    return options


def get_selection_from_wofi(wofi_options: str, nodes: List) -> Dict | None:
    # Call wofi and show the list. take the selected sink name and set it as the default sink
    wofi_command = f"echo '{wofi_options}' | wofi --show=dmenu --hide-scroll --allow-markup --define=hide_search=true --location=top_right --width=600 --height=200 --xoffset=-60"
    wofi_process = subprocess.run(
        wofi_command,
        shell=True,
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    selected_sink_name = wofi_process.stdout.strip()
    if selected_sink_name == "":
        return None
    selected_sink = next(
        node
        for node in nodes
        if get_property(node, "node.description") == selected_sink_name
    )
    return selected_sink


nodes = []
default_name = None
pipewire_state = get_pw_dump()

if len(sys.argv) > 1:
    (default_sink, default_source) = parse_metadata(pipewire_state)

    match sys.argv[1].lower():
        case "sink":
            default_name = default_sink
            nodes = parse_nodes(pipewire_state, MEDIA_CLASS_SINK)
        case "source":
            default_name = default_source
            nodes = parse_nodes(pipewire_state, MEDIA_CLASS_SOURCE)
        case _:
            print("Unknown class")
            exit(1)
else:
    print("Required argument (sink|source) missing")
    exit(1)

wofi_options = get_wofi_options(nodes, default_name)
selected_index = get_selection_from_wofi(wofi_options, nodes)
if selected_index is not None:
    subprocess.run(f"wpctl set-default {selected_index['id']}", shell=True)
    subprocess.run(
        f"notify-send 'Changed audio {sys.argv[1]} to {get_property(selected_index, 'node.description')}'",
        shell=True,
    )
