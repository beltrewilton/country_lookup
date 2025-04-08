import requests
from bs4 import BeautifulSoup
import re
import os
import json
from PIL import Image
from io import BytesIO
import base64
import cairosvg

# conda install requests beautifulsoup4 pillow cairosvg

# Target page
url = 'https://en.wikipedia.org/wiki/List_of_country_calling_codes'
headers = {'User-Agent': 'Mozilla/5.0'}
response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.content, 'html.parser')

# Get the table
table = soup.select_one(".wikitable.sortable.sticky-header-multi")

data = []

# Make output folder for flags
os.makedirs("flags", exist_ok=True)
os.makedirs("../data", exist_ok=True)

for row in table.select('tbody tr'):
    cols = row.find_all('td')
    if len(cols) < 2:
        continue

    name = cols[0].get_text(strip=True)
    dial_raw = cols[1].get_text(strip=True)

    # Parse code
    match = re.findall(r'\d+', dial_raw)
    if not match:
        continue

    country_code = match[0]
    national_codes = match[1:]
    dial_codes = [country_code + nc for nc in national_codes] if national_codes else [country_code]

    # Flag handling
    img_tag = cols[0].find('img')
    svg_content = None
    flag_image = None

    if img_tag:
        img_src = img_tag['src']
        img_url = f"https:{img_src}"
        img_name = os.path.basename(img_src.split('/')[-1])
        img_path = os.path.join("flags", img_name)

        # Download image
        img_data = requests.get(img_url).content
        with open(img_path, 'wb') as f:
            f.write(img_data)

        # Convert to SVG or embed SVG
        if img_name.endswith(".svg.png") or img_name.endswith(".png"):
            # Convert PNG to SVG via base64 (not vectorized, just embedded)
            flag_image = base64.b64encode(img_data).decode('utf-8')

        elif img_name.endswith(".svg"):
            flag_image = None

    data.append({
        "name": name,
        "dial_codes": dial_codes,
        "flag_image": flag_image
    })

# Save JSON output
with open("../data/country_dial_data.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print("✅ Done! Saved to data/country_dial_data.json")
