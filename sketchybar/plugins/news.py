#!/usr/bin/env python3

import os
import subprocess
import urllib.request
import json
import time

# Colors from palette
GREEN = "0xffb7cc85"
DIM = "0xff565f89"


def fetch_news_headline():
    """
    Intenta obtener el titular principal de un feed RSS simple.
    Si falla, retorna un placeholder elegante.
    """
    try:
        # Usar RSS Anyfeeds o NewsAPI free tier como fallback
        # Por ahora, stub que muestra placeholder
        # En producción, podría usar: https://feeds.reuters.com/reuters/businessNews
        return "📰 Top Stories", GREEN
    except Exception as e:
        return "📰 --", DIM


def main():
    name = os.environ.get("NAME", "news")

    # Obtener titular
    label, color = fetch_news_headline()

    # Update sketchybar
    subprocess.run(
        ["sketchybar", "--set", name, f"label={label}", f"label.color={color}"]
    )


if __name__ == "__main__":
    main()
