# Bad Game (Balls?) - iOS Port (iPhone 17 Pro / iOS 27 Ready)

This is a complete, native **IL2CPP iOS port** of Dani's game **Bad Game** (Balls?). It is pre-configured and pre-compiled into an Xcode project ready to build via **GitHub Actions** on a macOS runner to generate a signed/sideloadable `.ipa` without requiring a Mac.

---

## 🚀 Key Improvements & Fixes Over The Original

1. **Pure IL2CPP 64-bit Native C++ (No Mono JIT Crash)**:
   - The previous crash on iOS was caused by running Mono without JIT entitlements and runtime code emission.
   - Scripting is compiled via IL2CPP into `Classes/Native/Assembly-CSharp.cpp`, fully compliant with modern iOS security, 16KB page alignment, and ARM64 architecture.

2. **Replaced Unsupported XML Serialization (`SaveManager`)**:
   - `SaveManager` was rewritten to use Unity's native `JsonUtility.ToJson` / `FromJson` with `[Serializable] PlayerSave`.
   - Eliminates the `System.Reflection.Emit` / `PlatformNotSupportedException` crash on launch.

3. **Multi-Touch & Mobile Controls (`PlayerMovement` & `Grappling`)**:
   - Upgraded controls to handle touch screens natively (`Input.touchCount`, `TouchPhase.Began`, `TouchPhase.Moved`, `TouchPhase.Ended`).
   - Integrated `EventSystem.current.IsPointerOverGameObject` filtering to prevent accidental grappling when tapping UI buttons (Pause, Shop, Upgrade).
   - Direct world-space coordinate conversion for pinpoint touch grappling accuracy.
   - `LevelController` tap-to-skip XP tally screen now works with screen touches.

4. **120 FPS ProMotion Support (`Info.plist`)**:
   - Enabled `CADisableMinimumFrameDuration = true` in `Info.plist` and `Application.targetFrameRate = 120` for fluid 120Hz display on iPhone 17 Pro.

5. **Safe Native Ad & Offline Mechanics**:
   - Removed external ad SDK crashes (`UnityEngine.Advertisements`); rewarded video buttons now function smoothly offline.

6. **Metal-Optimized Post-Processing**:
   - Custom `Hidden_PixelateImaggeEffect.shader` rewritten in standard Unity CG and tested for Metal renderer compatibility.

7. **GitHub 100MB File Limit Handled**:
   - Large engine libraries (`libiPhone-lib.a` and `libil2cpp.a`) have been gzipped and split into <45MB chunks.
   - The `.github/workflows/build-ipa.yml` workflow automatically restores and verifies them before building.

---

## 📦 How to Build the `.ipa` via GitHub Actions (No Mac Needed)

### Step 1: Create a GitHub Repository
1. Go to [GitHub.com](https://github.com/new) and create a **New Repository** (e.g. `badgame-ios`).
2. Make it **Public** or **Private** (both work with GitHub Actions).

### Step 2: Push this Folder to Your Repository
Open PowerShell or Terminal in this folder (`ExportedProject-pc/build/ios`):

```bash
git remote add origin https://github.com/<YOUR_USERNAME>/badgame-ios.git
git branch -M main
git push -u origin main
```

*(If you ever need to force push: `git push -u origin main --force`)*

### Step 3: Download the `.ipa`
1. Go to your repository on GitHub and click the **Actions** tab.
2. The **"Build iOS IPA"** workflow will start automatically.
3. Once completed (approx. 2-3 minutes), scroll to the **Artifacts** section at the bottom of the run page.
4. Download **`BadGame-iOS-IPA.zip`**, extract it, and you will have `BadGame.ipa`!

---

## 📲 How to Install on iPhone (iOS 17 - 27)

You can sideload `BadGame.ipa` using any standard sideloading tool:
- **TrollStore** (if supported on your version): Open `BadGame.ipa` directly in TrollStore to install permanently.
- **LiveContainer**: Import `BadGame.ipa` into LiveContainer.
- **AltStore / SideStore**: Open `BadGame.ipa` in AltStore / SideStore.
- **Sideloadly**: Connect iPhone to PC, drag `BadGame.ipa` into Sideloadly, enter your Apple ID, and click **Start**.
