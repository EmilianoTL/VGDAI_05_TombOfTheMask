# VGDAI_05_TombOfTheMask 🎭

**Course:** Video Game Development and Artificial Intelligence (VGDAI)
**Engine:** Godot 4.x
**Topic:** 2D Grid-Based Movement & Game Logic

## 📝 Project Description
This project is a recreation of the core mechanics of *Tomb of the Mask*. It focuses on implementing specific movement constraints, collision handling, and game state management as per the course requirements.

## ✅ Features & Implementation

### 1. Movement System [CharacterBody2D]
* [cite_start]**Grid-Based Movement:** The player moves with constant velocity in four directions (WASD/Arrows) until collision[cite: 3, 4, 5].
* **Input Handling:** Input is disabled while the character is moving. [cite_start]Direction changes are only allowed when the player is grounded (touching a wall/floor)[cite: 11, 12].
* [cite_start]**Orientation:** The sprite automatically rotates to face the displacement direction[cite: 7].

### 2. Camera Logic
* [cite_start]**Custom Script:** The camera is decoupled from the player hierarchy.
* [cite_start]**Behavior:** It remains static on the X-axis but follows the player smoothly on the Y-axis to track vertical progression[cite: 27, 30].

### 3. Game Architecture
* [cite_start]**Game Manager:** A global script (Autoload) that tracks the score and stores the maximum height reached between runs[cite: 24, 25].
* **Collectibles:** Two types of items implemented with signals:
	* *Dots:* +1 Point.
	* [cite_start]*Big Bubbles:* +5 Points[cite: 44].
* **Hazards:** Spikes and obstacles detect the player via Groups/Areas. [cite_start]Death triggers a level restart after a short delay[cite: 38, 41].

### 4. Assets & Audio
* [cite_start]**Animations:** Idle, Moving, and Death states managed via code[cite: 21, 23].
* [cite_start]**SFX:** Audio feedback implemented for Jumping, Taking Damage, Collecting items, and Background Music[cite: 61, 62, 63].

## 🎮 Controls
| Key | Action |
| :--- | :--- |
| **W / Up** | Move Up |
| **S / Down** | Move Down |
| **A / Left** | Move Left |
| **D / Right** | Move Right |
| **R** | Restart Level (Debug) |

## 📺 Gameplay Demo
*(Paste your YouTube link here or upload a GIF to the /Demos folder)*
[Watch Gameplay Video](#)
