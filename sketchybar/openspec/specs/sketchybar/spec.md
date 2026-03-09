# Specification: sketchybar Configuration

**Domain**: sketchybar  
**Status**: ACTIVE  
**Last Updated**: 2026-03-09  
**Version**: 1.1.0 (v3.1 internal)

---

## Revision History
- **v1.0.0**: Initial modular configuration (2026-03-08).
- **v1.1.0**: Deep cleanup of legacy shell scripts and unused python plugins. Restored battery, datetime, and volume as core modules (2026-03-09).

### Requirement: RIGHT Sidebar Content (Updated 2026-03-09)

**Category**: Structure  
**Status**: OPTIMIZED  
**Version**: 1.1.4

The RIGHT sidebar items MUST follow these specific UI/UX constraints for the "System" island:
1. **datetime (calendar.py)**:
   - Format: `%a %d %b | %H:%M` (24h with separator).
   - Dimensions: `label.width=155`, `label.padding_left=15` (to prevent text clipping).
   - Junction: `label.padding_right=0` (compact connection with battery).
2. **battery (battery.py)**:
   - Status: **VERIFIED (v3.2.1)**
   - Logic: Multi-level health alerts with debouncing.
   - Alerts: ⚠️ 20% (Low), 🚨 10% (Critical), ✅ 100% (Full).

3. **volume (volume.py)**:
   - Status: **VERIFIED (v3.4.1)**
   - Master Pause: Left-click toggles Mute AND pauses Spotify + stops Radio.
   - UI: `label.padding_right=0` (compacted with Bluetooth).
   - Icons: Dynamic mapping (󰝟, 󰕿, 󰖀, 󰕾) with Red alert for Mute/0%.
   - Validation: Passed `tests/test_volume.py`.

4. **radio (radio.py)**:
   - Status: **PENDING INTEGRAL REVISION**

---

## SDD Workflow & Validation Mandate

Every plugin modification MUST follow this lifecycle:
1. **Delta Spec**: Create a specific requirement file in `openspec/changes/`.
2. **Implementation**: Surgical update of the `.py` or `.sh` file.
3. **Automated Testing**: 
   - A test script MUST be created in `tests/test_[plugin_name].py`.
   - The test MUST simulate edge cases (thresholds, missing tools, connectivity drops).
4. **Manual Verification**: Reload sketchybar and verify visual integrity.
5. **Archiving**: Merge specs and delete temporary test scripts if appropriate.

---

## Overview

Configuration and behavior specification for the sketchybar status bar. Defines the visual layout, item placement, styling, and interaction model for LEFT and RIGHT sidebars.

---

## Requirements

### Requirement: LEFT Sidebar Content

**Category**: Structure  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The LEFT sidebar MUST display items in the following order (top to bottom):
1. SPACES (spaces 1-10 hardcoded, ~27 lines)
2. front_app (current active application label, event-driven, ~21 lines)
3. meeting (upcoming meeting info, color CYAN, relocated from RIGHT, ~18 lines)
4. happy_hacking (terminal shortcut, decorative, ~8 lines)

**Rationale**: Radical simplification. Show ONLY relevant context: current space indicator, active application, next meeting, and terminal access. Remove monitoring items (github, cpu, gpu, mail).

**Implementation**: 
- SPACES: lines 84-110 (unchanged)
- front_app: inserted after line 110 (from plugins/front_app.sh)
- meeting: inserted after happy_hacking (relocated from RIGHT, color: $CYAN instead of $YELLOW)
- happy_hacking: line ~359

**Validation**: Query `sketchybar --query items | jq '.[] | select(.position == "left") | .name'` expects: space.1, space.2, ..., space.10, front_app, meeting, happy_hacking

---

### Requirement: RIGHT Sidebar Content

**Category**: Structure  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The RIGHT sidebar MUST display items in the following order (right to left):
1. battery (battery indicator, GREEN)
2. datetime (date and time, GRAY)
3. music (music player integration, WHITE)
4. volume (volume control slider, GRAY)
5. mic (microphone status, RED if active, GRAY if off)
6. ram (memory usage indicator, ORANGE)

**Rationale**: Consolidated RIGHT sidebar showing only functional status indicators. Meeting moved to LEFT to reduce visual clutter on RIGHT.

**Implementation**:
- battery: unchanged
- datetime: unchanged
- music: unchanged (meeting REMOVED from this context)
- volume: unchanged
- mic: unchanged
- ram: unchanged

**Validation**: Query `sketchybar --query items | jq '.[] | select(.position == "right") | .name'` expects: battery, datetime, music, volume, mic, ram

---

### Requirement: Item Removals from LEFT

**Category**: Structure  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The following items MUST be removed from the LEFT sidebar:
1. github (18 lines, lines 248-265)
2. cpu (18 lines, lines 270-287)
3. gpu (18 lines, lines 289-306)
4. mail (12 lines, lines 333-344)

**Rationale**: These monitoring items clutter the LEFT sidebar. Users requested "only the app of current space, nothing else."

**Implementation**: Deleted via sed operations in reverse order (A5→A4→A3→A2→A1) to preserve line numbering.

**Validation**: Item count before deletions: ~360 lines. After deletions: ~280 lines. No errors during `bash sketchybarrc` syntax check.

---

### Requirement: Meeting Styling

**Category**: Styling  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The meeting item MUST use CYAN color (#ff00ffff) to differentiate from datetime (which uses YELLOW).

**Rationale**: Previously both meeting and datetime used YELLOW, causing visual confusion. Moving meeting to LEFT with CYAN eliminates this conflict.

**Implementation**:
- Color changed from `$YELLOW` to `$CYAN` (0xff00ffff)
- Position changed from `right` to `left`
- Position in LEFT: after happy_hacking

**Validation**: Query `sketchybar --query items | grep meeting | jq '.color'` expects: 0xff00ffff

---

### Requirement: Front App Integration

**Category**: Behavior  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The front_app item MUST display the currently active application label and update event-driven when the user switches applications.

**Rationale**: Provides context for the current space by showing which app is in focus.

**Implementation**:
- Source: `/Users/statick/.config/sketchybar/plugins/front_app.sh` (~21 lines, already exists)
- Event: triggered by `front_app_switched` from Windowserver
- Position in LEFT: after SPACES loop (line 110)

**Validation**: 
- Item exists: `sketchybar --query items | grep front_app`
- Event listener active: `sketchybar --query front_app | jq '.name'` expects: front_app
- Manual test: switch apps, front_app label updates within 1 second

---

### Requirement: File Size

**Category**: Performance  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The sketchybarrc file MUST NOT exceed 350 lines after changes.

**Rationale**: Maintainability and clarity. Smaller config files are easier to audit and modify.

**Implementation**: Final size after all deletions and insertions: ~320 lines

**Validation**: `wc -l /Users/statick/.config/sketchybar/sketchybarrc` expects: ≤350

---

### Requirement: Syntax Validation

**Category**: Quality  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The sketchybarrc configuration file MUST pass Bash syntax validation with zero errors.

**Rationale**: Prevents broken config from preventing sketchybar from loading.

**Implementation**: Check `bash -n /Users/statick/.config/sketchybar/sketchybarrc` returns exit code 0

**Validation**: `bash -n /Users/statick/.config/sketchybar/sketchybarrc && echo "Syntax OK"`

---

### Requirement: Runtime Validation

**Category**: Quality  
**Status**: IMPLEMENTED  
**Version**: 1.0 (Updated 2026-03-08)

The sketchybar daemon MUST successfully reload the configuration without errors after changes.

**Rationale**: Config syntax may be valid but fail at runtime due to missing items, circular references, or plugin errors.

**Implementation**: Execute `sketchybar --reload` and check for error messages in `sketchybar --query items`

**Validation**: `sketchybar --reload > /tmp/reload.log 2>&1 && echo "Reload OK"`

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      SKETCHYBAR LAYOUT                          │
├──────────────────────────────┬──────────────────────────────────┤
│     LEFT SIDEBAR             │      RIGHT SIDEBAR               │
├──────────────────────────────┼──────────────────────────────────┤
│ SPACES (1-10)                │ battery                          │
│ front_app (active app)       │ datetime                         │
│ meeting (CYAN)               │ music                            │
│ happy_hacking (terminal)     │ volume                           │
│                              │ mic                              │
│                              │ ram                              │
└──────────────────────────────┴──────────────────────────────────┘
```

---

## Consolidated Plugins Requirements (Added 2026-03-08)

### Requirement: system-stats.py Consolidates CPU, GPU, RAM Metrics

The `plugins/system-stats.py` plugin MUST collect and output CPU usage, GPU utilization, and RAM usage metrics in a single subprocess call.

**Rationale**: Previously spread across `cpu.py`, `gpu.py`, `ram.py` (3 separate subprocesses). Consolidation reduces process overhead and clarifies single source of truth for system metrics.

**Key Scenarios**:
- CPU metric displays correctly with real-time updates (>50% under workload)
- GPU shows 0% when idle (expected, not error state)
- RAM displays both percentage (e.g., 42%) and absolute values (8GB / 16GB)
- No subprocess errors on plugin execution

---

### Requirement: connectivity.py Consolidates WiFi Monitoring

The `plugins/connectivity.py` plugin MUST collect and output WiFi status and signal strength metrics.

**Rationale**: Previously scattered in `wifi.py`. Consolidation clarifies connectivity as a single responsibility domain.

**Key Scenarios**:
- WiFi status displays current network SSID or connection status
- WiFi signal strength displays bars, percentage, or dBm
- No errors when querying WiFi metrics

---

### Requirement: battery.py Dedicated to Battery Metrics

The `plugins/battery.py` plugin MUST collect and output battery percentage and health status.

**Rationale**: Battery is a separate concern from system metrics and connectivity. Dedicated plugin allows independent update frequency and failure handling.

**Key Scenarios**:
- Battery percentage displays correctly (e.g., 78%)
- Battery health status included when available (optional)
- Updates reflect battery drain/charge cycles in real-time

---

### Requirement: sketchybarrc References Consolidated Plugins Only

The bar item configuration in `sketchybarrc` MUST reference only the 3 consolidated plugins (`system-stats.py`, `connectivity.py`, `battery.py`) and MUST NOT reference deleted plugins (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`).

**Key Scenarios**:
- CPU bar item references `plugins/system-stats.py`, not `plugins/cpu.py`
- WiFi bar item references `plugins/connectivity.py`, not `plugins/wifi.py`
- RAM bar item references `plugins/system-stats.py`
- No "file not found" errors on bar load

---

### Requirement: Old Plugin Files Removed from Disk and Git History

The old fragmented plugins (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`) MUST be deleted from disk and removed from git history.

**Key Scenarios**:
- `cpu.py`, `gpu.py`, `ram.py` do NOT appear in `ls plugins/`
- `wifi.py` removed; connectivity metrics from `connectivity.py` only
- Git history reflects deletions: `git log --diff-filter=D --summary` shows deleted files
- Files recoverable via `git show HEAD~N:plugins/{filename}` for audit

---

### Requirement: No Subprocess Overhead Increase

The consolidation MUST NOT increase subprocess overhead; subprocess count MUST decrease from 9+ plugins to 3.

**Key Scenario**:
- When monitoring system processes (`ps aux | grep python`), count of python plugin subprocesses ≤ 3
- Fewer processes than or equal to previous count of 9+

---

### Requirement: Plugin Failures Do Not Cascade

If one consolidated plugin fails (e.g., `system-stats.py` crashes), the failure MUST NOT affect other plugins (`connectivity.py`, `battery.py`).

**Key Scenario**:
- If `system-stats.py` fails, CPU/GPU/RAM metrics may display errors or stale values
- Battery metric from `battery.py` continues to update normally
- No cascading error affects the entire bar

---

### Requirement: Graceful Degradation on Missing System Tools

If system tools required by a plugin are unavailable, the plugin MUST gracefully degrade.

**Key Scenario**:
- If GPU monitoring tools unavailable, GPU displays as `N/A` or `—` (not error)
- CPU and RAM metrics still update correctly
- No exception raised

---

## Change History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 3.0 | 2026-03-08 | Plugin consolidation: 9+ fragmented plugins consolidated to 3 focused plugins (system-stats.py, connectivity.py, battery.py), reduced subprocess overhead, old plugin files deleted, graceful degradation on missing tools | statick |
| 2.0 | 2026-03-08 | Advanced integrations: 11 items (front_app, music, datetime, battery, wifi, bluetooth, volume, ram, cpu, gpu, pomodoro), real-time updates, event subscriptions, Pomodoro timer with state persistence | statick |
| 1.0 | 2026-03-08 | Initial spec: LEFT simplification, meeting moved to LEFT with CYAN color, front_app integration, github/cpu/gpu/mail removed | statick |

---

## Related Artifacts

- **Proposal**: Change proposal with user intent and scope
- **Design**: Technical design with line-by-line mapping and code blocks
- **Tasks**: 12 actionable tasks across 4 phases (deletions, insertions, validation, testing)
- **Implementation**: `/Users/statick/.config/sketchybar/sketchybarrc`

---

## Acceptance Criteria

- [x] LEFT sidebar shows: SPACES, front_app, meeting (CYAN), happy_hacking
- [x] RIGHT sidebar shows: battery, datetime, music, volume, mic, ram
- [x] github, cpu, gpu, mail removed from LEFT
- [x] meeting moved to LEFT with CYAN color
- [x] front_app integrated and event-driven
- [x] File size ≤ 350 lines
- [x] Syntax validation passes (bash -n)
- [x] Runtime reload succeeds (sketchybar --reload)
- [x] All 12 tasks executed successfully
- [x] Item placement verified (sketchybar --query items)
- [x] Click interactions functional (all items respond to clicks)
