#!/usr/bin/env python3
"""
Gentleman Sketchybar - Paleta de colores centralizada
Matching Ghostty/Neovim theme
"""

COLORS = {
    # Base colors
    "BLACK": "0xff06080f",
    "WHITE": "0xfff3f6f9",
    "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85",
    "YELLOW": "0xffffe066",
    "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca",
    "MAGENTA": "0xffff8dd7",
    "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000",
    # Island colors
    "ISLAND_BG": "0xff121620",
    "ISLAND_BORDER": "0xff263356",
    "ACCENT_COLOR": "0xffe0c15a",
    "DIM": "0xff565f89",
}

# Para uso directo: from colors import BLACK, WHITE, RED, etc.
BLACK = COLORS["BLACK"]
WHITE = COLORS["WHITE"]
RED = COLORS["RED"]
GREEN = COLORS["GREEN"]
YELLOW = COLORS["YELLOW"]
ORANGE = COLORS["ORANGE"]
BLUE = COLORS["BLUE"]
MAGENTA = COLORS["MAGENTA"]
CYAN = COLORS["CYAN"]
TRANSPARENT = COLORS["TRANSPARENT"]
ISLAND_BG = COLORS["ISLAND_BG"]
ISLAND_BORDER = COLORS["ISLAND_BORDER"]
ACCENT_COLOR = COLORS["ACCENT_COLOR"]
DIM = COLORS["DIM"]

__all__ = [
    "COLORS",
    "BLACK",
    "WHITE",
    "RED",
    "GREEN",
    "YELLOW",
    "ORANGE",
    "BLUE",
    "MAGENTA",
    "CYAN",
    "TRANSPARENT",
    "ISLAND_BG",
    "ISLAND_BORDER",
    "ACCENT_COLOR",
    "DIM",
]
