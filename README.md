# Minimalist Focus Timer — HCI Project (CS798H)

> A clean, distraction-free **focus timer** with lightweight task tracking and theme customization. Built for **simplicity over complexity**, inspired by the Pomodoro technique and informed by user research and iterative evaluation.

---

## Table of Contents

- [Why this project?](#why-this-project)
- [Key Features](#key-features)
- [Screens & Flows](#screens--flows)
- [User Research & Needfinding](#user-research--needfinding)
- [Evaluation Methods](#evaluation-methods)
- [Assigned Tasks & Outcomes (Highlights)](#assigned-tasks--outcomes-highlights)
- [Findings & Takeaways](#findings--takeaways)
- [Roadmap](#roadmap)
- [Getting Started](#getting-started)
- [Suggested Folder Structure](#suggested-folder-structure)
- [Authors](#authors)
- [References & Data](#references--data)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Why this project?

Most focus apps (e.g., Focus To-Do, Forest, Pomodoro Timer) overload users with features and notifications that can **increase** cognitive load. This project targets a **minimal UI** that helps users start, sustain, and complete focus sessions with the **least friction**.

---

## Key Features

- **Single-tap start** on a large timer (play/pause)
- **Custom durations** via tap-to-edit (hours/minutes)
- **Break prompt** at session end (“Start Break” / “Skip”)
- **Basic task list** with add + complete (checkbox)
- **Theme customization**, default dark; multiple themes
- **Settings toggles:** Strict Mode, Vibration, White Noise _(planned)_
- **Orientation toggle** (portrait/landscape)

---

## Screens & Flows

- **Home (Timer):** Large countdown, start/pause, orientation
- **Session Complete Dialog:** Start Break / Skip
- **Task Manager:** Add tasks, mark done
- **Settings:** Theme grid; toggles for strict mode, vibration, white noise

---

## User Research & Needfinding

- Interviews with students and focus-app users; review of app store and community feedback
- Key needs: **simple timer**, **adjustable durations**, **minimal setup**, **dark theme**, **task list**, **ambient audio**, **low cognitive load**

---

## Evaluation Methods

- **Usability Tests (n = 10):** Task-based observation + time/success metrics
- **User Survey:** 10 standard usability statements, 5-point Likert scale
- **Cognitive Walkthrough:** First-time user task analysis

---

## Assigned Tasks & Outcomes (Highlights)

- **Start Focus Session:** 10/10 succeeded; minor confusion on orientation/reset icons
- **Set Custom Duration:** Only 4/10 discovered tap-to-edit without hint; once found, all used picker effectively
- **Handle Session Completion:** 9/10 understood “Start Break/Skip”; one user unsure post-Skip
- **Add a Task:** 7/10 completed; several expected timer linkage; missing delete/edit noted
- **Change Theme:** 10/10 succeeded; real-time switch appreciated; one theme disliked by many
- **Toggle Settings (White Noise/Strict/Vibration):** All found toggles; 6/10 unclear on meanings → need tooltips
- **Complete a Task:** 10/10 succeeded; requests for reminders/due-times

---

## Findings & Takeaways

### What worked well

- Minimal, intuitive UI → **low cognitive load**
- Large digital timer preferred over analog styles
- Theme customization appreciated

### What needs improvement

- **Discoverability** of tap-to-edit on timer
- Clarify **White Noise** and **Strict Mode** with tooltips
- **Task features:** deletion/editing; optional linkage with timer sessions
- Icon clarity for orientation; increase contrast for certain themes

---

## Roadmap

- [ ] Add microcopy/tooltips for settings & editable timer
- [ ] Link tasks to sessions (logs, reminders)
- [ ] Task delete/edit; due-times; optional calendar sync
- [ ] Improve iconography & theme contrast; remove unpopular theme
- [ ] Integrate white noise playback with volume controls

---

---
