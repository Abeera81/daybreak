"""Generate the dev.to cover image for Daybreak (1000x420)."""
from PIL import Image, ImageDraw, ImageFont
import os

W, H = 1000, 420
OUT = os.path.join(os.path.dirname(__file__), "cover.png")


def vertical_gradient(w, h, top, bottom):
    base = Image.new("RGB", (w, h), top)
    draw = ImageDraw.Draw(base)
    for y in range(h):
        t = y / max(1, h - 1)
        r = int(top[0] + (bottom[0] - top[0]) * t)
        g = int(top[1] + (bottom[1] - top[1]) * t)
        b = int(top[2] + (bottom[2] - top[2]) * t)
        draw.line([(0, y), (w, y)], fill=(r, g, b))
    return base


def load_font(paths, size):
    for p in paths:
        try:
            return ImageFont.truetype(p, size)
        except Exception:
            continue
    return ImageFont.load_default()


# Deep dawn gradient: navy -> warm horizon
img = vertical_gradient(W, H, (11, 18, 38), (32, 28, 64))
draw = ImageDraw.Draw(img)

# Subtle sunrise glow in the bottom-right (the "daybreak"), clear of the text
glow = Image.new("RGB", (W, H), (0, 0, 0))
gdraw = ImageDraw.Draw(glow)
cx, cy = 870, 470
for rad in range(420, 0, -2):
    t = rad / 420
    r = int(255 * (1 - t) ** 1.5)
    g = int(150 * (1 - t) ** 1.6)
    b = int(70 * (1 - t) ** 1.8)
    gdraw.ellipse([cx - rad, cy - rad, cx + rad, cy + rad], fill=(r, g, b))
img = Image.blend(img, glow, 0.40)
draw = ImageDraw.Draw(img)

# Sun arc rising from the bottom-right edge
horizon_y = 430
sun_r = 54
draw.ellipse([cx - sun_r, horizon_y - sun_r, cx + sun_r, horizon_y + sun_r],
             fill=(255, 196, 92))

win_paths = [
    "C:/Windows/Fonts/segoeuib.ttf",
    "C:/Windows/Fonts/arialbd.ttf",
    "C:/Windows/Fonts/Arial.ttf",
]
win_paths_reg = [
    "C:/Windows/Fonts/segoeui.ttf",
    "C:/Windows/Fonts/Arial.ttf",
]

f_brand = load_font(win_paths, 40)
f_title = load_font(win_paths, 72)
f_sub = load_font(win_paths_reg, 26)
f_badge = load_font(win_paths, 30)

# Brand
draw.text((60, 56), "DAYBREAK", font=f_brand, fill=(255, 209, 128))

# Headline (two lines)
draw.text((60, 132), "The agent you", font=f_title, fill=(245, 247, 255))
draw.text((60, 210), "never open.", font=f_title, fill=(245, 247, 255))

# Subtitle
draw.text((62, 312), "Autonomous  -  Self-improving  -  It speaks",
          font=f_sub, fill=(176, 188, 222))

img.save(OUT, "PNG")
print("Saved", OUT, img.size)
