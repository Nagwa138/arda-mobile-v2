import os
import re

# characters to detect
PATTERN = re.compile(r'[â€™â€œâ€â€“â€”]')

PROJECT_PATH = "./"   # غيره لو محتاج

def scan_file(path):
    try:
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            for i, line in enumerate(f, start=1):
                if PATTERN.search(line):
                    print(f"\n📄 File: {path}")
                    print(f"📍 Line {i}: {line.strip()}")
    except Exception as e:
        print(f"❌ Error reading {path}: {e}")

for root, _, files in os.walk(PROJECT_PATH):
    for file in files:
        if file.endswith(('.dart', '.md', '.txt', '.json', '.yaml')):
            scan_file(os.path.join(root, file))
