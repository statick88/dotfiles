#!/usr/bin/env python3

import json
import os
import subprocess


def main():
    name = os.environ.get("NAME", "front_app")

    try:
        result = subprocess.run(
            ["yabai", "-m", "query", "--windows", "--window"],
            capture_output=True,
            text=True,
        )
        data = json.loads(result.stdout)
        app = data.get("app", "")
        title = data.get("title", "")

        # If title is very long (>50 chars), show only app name
        # Otherwise show "AppName: Window Title"
        if title:
            if len(title) > 50:
                label = app
            else:
                label = f"{app}: {title}"
        else:
            label = app
    except Exception:
        label = ""

    subprocess.run(["sketchybar", "--set", name, f"label={label}"])


if __name__ == "__main__":
    main()
