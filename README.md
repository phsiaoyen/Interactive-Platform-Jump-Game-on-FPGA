# Doodle Jump on FPGA

This project implements Doodle Jump on an FPGA using Verilog HDL. Players control the character with a keyboard, jumping on randomly generated platforms to avoid falling.

## Description
Key Features:

- FSM Game Control: WAIT, INTRODUCTION, GAME, WIN, LOSE states.

- Random Platforms & Collision: LFSR-based generation with pixel-level collision detection.

- Character Motion: Gravity-like vertical movement with platform-specific behavior.

- Graphics & Display: Pixel addressing for smooth VGA output and background removal.

- Sound & Score: Event-driven audio and real-time score on seven-segment display.
