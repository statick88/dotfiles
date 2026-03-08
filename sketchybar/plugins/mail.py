#!/usr/bin/env python3
"""
Mail plugin: Simple menu-based Gmail account switcher.
No scraping, no APIs, no Selenium. Just clean Chrome profile switching.

Accounts (aliased):
  - personal: dsaavedra88@gmail.com (Default profile)
  - ucm: diegsaav@ucm.es (Profile 1)
  - utpl: dmsaavedra3@utpl.edu.ec (Profile 2)
  - fullstack: fullstackec@gmail.com (Profile 3)
"""

import os
import subprocess

# Colors
MAGENTA = "0xffff8dd7"


def update_label(label_text, color):
    """Update mail label in sketchybar."""
    name = os.environ.get("NAME", "mail")
    subprocess.run(
        [
            "sketchybar",
            "--set",
            name,
            f"label={label_text}",
            f"label.color={color}",
        ],
        check=False,
    )


def main():
    """Main entry point - just update the label."""
    # Simple label: 📧 Inbox
    # The popup menu is pre-defined in sketchybarrc
    label = "📧 Inbox"
    color = MAGENTA
    update_label(label, color)


if __name__ == "__main__":
    main()
