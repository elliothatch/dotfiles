import ranger.api
from ranger.core.linemode import LinemodeBase

import json
from subprocess import check_output, DEVNULL

# Don't actually use this. Takes like 1/3rd of a second per file.
# consider autogenerating .metadata.json and just reading that instead

@ranger.api.register_linemode
class MusicMetaLinemode(LinemodeBase):
    name = "musicmeta"

    uses_metadata = False


    def filetitle(self, file, metadata):
        tags = get_tags(file.path)
        if "title" not in tags:
            return file.relative_path

        return tags["title"]

    def infostring(self, file, metadata):
        tags = get_tags(file.path)

        parts = []
        if "artist" in tags:
            parts.append(tags["artist"])
        if "album" in tags:
            parts.append(tags["album"])
        if "track" in tags:
            parts.append(tags["track"])

        if len(parts) > 0:
            return " - ".join(parts)
        else:
            raise NotImplementedError

def get_tags(filepath):
    try:
        lines = check_output(["ffprobe", "-show_format", "-print_format", "json", filepath], stderr=DEVNULL, universal_newlines=True)
        props = json.loads(lines)
        return props["format"]["tags"]
    except Exception as e:
        return {}
