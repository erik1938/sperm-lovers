# Prologue Scene Plan

## 🎮 Concept: "Corrupted Biology Textbook"

A PS1-style prologue that feels like a **glitchy, sardonic biology lesson** — fitting your game's irreverent tone and Doorethy's personality.

---

## 📐 Visual Layout (PS1 Aesthetic)

```
┌──────────────────────────────────────────────────────────────┐
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│  ║                     [ SCANLINE EFFECT ]                 ║  │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                              │
│        ┌─────────────────────────────────────────┐           │
│        │  ░░░░░ TEXTBOOK-STYLE HEADER ░░░░░░    │           │
│        │  "CHAPTER 0: THE RACE"                  │           │
│        └─────────────────────────────────────────┘           │
│                                                              │
│   ╔══════════════════════════════════════════════════════╗   │
│   ║  MAIN TEXT BOX (typewriter effect)                   ║   │
│   ║                                                      ║   │
│   ║  "You are one of 300 million."                       ║   │
│   ║  "The odds are not in your favor."                   ║   │
│   ║  "But you have something the others don't..."        ║   │
│   ║                                                      ║   │
│   ║                              ▸ [CLICK TO CONTINUE]   ║   │
│   ╚══════════════════════════════════════════════════════╝   │
│                                                              │
│           ┌──────────────────────────────────┐               │
│           │  [SPERM SPRITE PREVIEW]          │  ← animation │
│           └──────────────────────────────────┘               │
│                                                              │
│                    [ PAGE 1 / 5 ]                            │
└──────────────────────────────────────────────────────────────┘
```

---

## 📜 Content Structure (5 Pages)

### **Page 1: The Setup**

> _"CHAPTER 0: THE RACE"_
>
> You are one of 300 million.
>
> Most will perish in the first minute.
> The rest will tire and fall behind.
> Only ONE can reach the egg.

### **Page 2: The Twist**

> _"CHAPTER 0.1: THE ANOMALY"_
>
> But you... you're different.
>
> You woke up.
> You can THINK.
> And somehow... you have a SHOTGUN.
>
> _[glitch effect]_

### **Page 3: The Moral Choice**

> _"CHAPTER 0.2: THE PATH"_
>
> There are two ways to the egg:
>
> 🕊️ **THE PACIFIST** — Solve puzzles. Help the doors.
> Spare your siblings. Earn KARMA.
>
> 💀 **THE VIOLENT** — Blast through everything.
> Shotgun goes BOOM. Karma goes DOWN.
>
> Your choices matter. Probably.

### **Page 4: Controls**

> _"SURVIVAL MANUAL"_
>
> ```
> WASD .............. SWIM
> HOLD RIGHT CLICK .. AIM
> LEFT CLICK ........ SHOOT / TALK / INTERACT WITH OBJECTS IN CERTAIN LEVELS
> ```
>
> TIP: Some doors just want to chat. Others need convincing.

### **Page 5: Final Warning**

> _"DISCLAIMER"_
>
> Doorethy is watching.
> She's always watching.
>
> Good luck, little one.
>
> _[PRESS ANY KEY TO BEGIN]_

---

## 🛠️ Technical Implementation

### Scene Structure

```
prologue.tscn
├── CanvasLayer
│   ├── ColorRect (black background)
│   ├── TextureRect (CRT scanline overlay)
│   ├── VBoxContainer (centered)
│   │   ├── ChapterLabel (header text)
│   │   ├── Panel (main text box - dark red border, PS1 style)
│   │   │   └── RichTextLabel (typewriter text)
│   │   ├── SpritePreview (optional animated sperm)
│   │   └── PageIndicator ("Page 1/5")
│   └── HintLabel ("Click to continue...")
└── prologue.gd (script)
```

### Script Features

```gdscript
# Key features:
- pages: Array of {chapter: String, text: String}
- current_page: int
- typewriter effect (reuse text_speed from dialog_system.gd)
- input: click/space to advance, skip typewriter if mid-animation
- glitch effect on Page 2 (screen shake + color shift)
- transition: after Page 5, change_scene to level1 (or test_level)
```

### PS1 Visual Effects

| Effect            | Implementation                                           |
| ----------------- | -------------------------------------------------------- |
| **Scanlines**     | TextureRect with repeating horizontal lines, low opacity |
| **Dithering**     | Apply your existing PSX_shader.gdshader via material     |
| **CRT Curve**     | Optional subtle barrel distortion shader                 |
| **Low-res text**  | Use pixel font at 8-16px, `filter_nearest`               |
| **Color palette** | Dark reds, maroons, grays (match your UI theme)          |

### Font Suggestion

- Use a **pixel/bitmap font** like "Press Start 2P" or "VCR OSD Mono"
- Apply with `theme_override_fonts` on RichTextLabels

---

## 🎨 Style Consistency

| Element      | Your Main Menu   | Prologue (Suggested)          |
| ------------ | ---------------- | ----------------------------- |
| Background   | Dark gray        | Pure black + scanlines        |
| Text color   | Red (#DE0000)    | Same red for headers          |
| Button style | Rounded dark box | Same panel style for text box |
| Font size    | 19px             | 16-19px (same scale)          |

---

## 📁 Files to Create

| File                                     | Purpose                      |
| ---------------------------------------- | ---------------------------- |
| `scenes/prologue.tscn`                   | The scene                    |
| `scripts/prologue.gd`                    | Logic + typewriter           |
| `art/textures/scanlines.png`             | Optional CRT overlay         |
| `art/dialogSystem/prologue_content.json` | _OR_ hardcode text in script |

---

## 🔗 Integration

Update main menu to go to prologue first:

```gdscript
# main_menu.gd
func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/prologue.tscn")
```

---

## ✅ Implementation Checklist

- [ ] Create `prologue.gd` script with typewriter effect
- [ ] Create `prologue.tscn` scene with PS1 layout
- [ ] Add scanline overlay texture (optional)
- [ ] Add glitch effect for Page 2
- [ ] Update `main_menu.gd` to load prologue first
- [ ] Test full flow: Main Menu → Prologue → Level 1
