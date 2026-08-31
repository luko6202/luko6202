#!/usr/bin/env python3
"""Create an A4 poster for the rhythmic gymnastics course."""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
ASSET = ROOT / "assets" / "rhythmische-sportgymnastik-illustration.png"
OUTPUT_DIR = ROOT / "output"
PNG_OUTPUT = OUTPUT_DIR / "plakat-rhythmische-sportgymnastik-a4.png"

WIDTH, HEIGHT = 2480, 3508
NAVY = "#0C2D5B"
CORAL = "#F0645C"
GOLD = "#F9B947"
CREAM = "#FFFCF5"
WHITE = "#FFFFFF"
MINT = "#DCEDE9"

FONT_REGULAR = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
FONT_BOLD = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"


def font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(FONT_BOLD if bold else FONT_REGULAR, size)


def fit_cover(image: Image.Image, size: tuple[int, int]) -> Image.Image:
    target_width, target_height = size
    scale = max(target_width / image.width, target_height / image.height)
    resized = image.resize(
        (round(image.width * scale), round(image.height * scale)),
        Image.Resampling.LANCZOS,
    )
    left = (resized.width - target_width) // 2
    top = (resized.height - target_height) // 2
    return resized.crop((left, top, left + target_width, top + target_height))


def draw_centered(
    draw: ImageDraw.ImageDraw,
    box: tuple[int, int, int, int],
    text: str,
    text_font: ImageFont.FreeTypeFont,
    fill: str,
) -> None:
    x1, y1, x2, y2 = box
    bounds = draw.textbbox((0, 0), text, font=text_font)
    text_width = bounds[2] - bounds[0]
    text_height = bounds[3] - bounds[1]
    draw.text(
        ((x1 + x2 - text_width) / 2, (y1 + y2 - text_height) / 2 - bounds[1]),
        text,
        font=text_font,
        fill=fill,
    )


def rounded_panel(
    base: Image.Image,
    box: tuple[int, int, int, int],
    radius: int,
    fill: str,
    opacity: int = 255,
) -> None:
    layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
    ImageDraw.Draw(layer).rounded_rectangle(box, radius=radius, fill=fill + f"{opacity:02x}")
    base.alpha_composite(layer)


def create_poster() -> Image.Image:
    background = fit_cover(Image.open(ASSET).convert("RGB"), (WIDTH, HEIGHT)).convert("RGBA")

    # A calm field behind the headline keeps the message readable while preserving
    # the movement of the illustration.
    rounded_panel(background, (105, 110, 1610, 1980), 72, CREAM, 242)
    draw = ImageDraw.Draw(background)

    draw.rounded_rectangle((185, 190, 720, 310), radius=60, fill=CORAL)
    draw_centered(draw, (185, 190, 720, 310), "KURSANGEBOT", font(49, True), WHITE)

    draw.text((185, 395), "AN ALLE", font=font(62, True), fill=CORAL)
    draw.text((185, 485), "MÄDCHEN & JUNGEN", font=font(88, True), fill=NAVY)
    draw.text((185, 600), "VON DER 1. BIS 13. KLASSE!", font=font(52, True), fill=NAVY)

    draw.rounded_rectangle((185, 755, 425, 783), radius=14, fill=GOLD)
    draw.text((185, 845), "RHYTHMISCHE", font=font(102, True), fill=NAVY)
    draw.text((175, 980), "SPORT", font=font(190, True), fill=NAVY)
    draw.text((175, 1175), "GYMNASTIK", font=font(161, True), fill=NAVY)
    draw.text((185, 1390), "TRAINING", font=font(63, True), fill=CORAL)

    draw.rounded_rectangle((185, 1560, 985, 1680), radius=60, fill=MINT)
    draw_centered(
        draw,
        (185, 1560, 985, 1680),
        "KOMM VORBEI & MACH MIT!",
        font(44, True),
        NAVY,
    )

    # The schedule and venue form a single high-contrast information card.
    rounded_panel(background, (105, 2410, 1675, 3345), 72, NAVY, 250)
    draw = ImageDraw.Draw(background)
    draw.text((185, 2500), "JEDEN MITTWOCH", font=font(76, True), fill=WHITE)
    draw.text((175, 2610), "17–19 UHR", font=font(157, True), fill=GOLD)
    draw.text((185, 2800), "AUSSER IN DEN FERIEN", font=font(48, True), fill=WHITE)
    draw.line((185, 2910, 1545, 2910), fill=CORAL, width=12)
    draw.text((185, 2980), "MEHRZWECKHALLE", font=font(52, True), fill=WHITE)
    draw.text((180, 3065), "Groß Köris", font=font(105, True), fill=WHITE)

    # Small visual anchors echo the hand apparatus in the illustration.
    draw.ellipse((1755, 3020, 2300, 3370), outline=CORAL, width=22)
    draw.ellipse((2040, 3150, 2195, 3305), fill=GOLD)

    return background.convert("RGB")


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    poster = create_poster()
    poster.save(PNG_OUTPUT, "PNG", dpi=(300, 300), optimize=True)
    print(f"Created {PNG_OUTPUT}")


if __name__ == "__main__":
    main()
