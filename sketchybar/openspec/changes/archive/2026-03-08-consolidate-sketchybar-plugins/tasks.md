# Task Breakdown: Consolidate Sketchybar Plugins

**Change**: consolidate-sketchybar-plugins  
**Total Tasks**: 12 (+ verification steps per task)  
**Estimated Effort**: 60-90 minutes total  
**Dependencies**: None (self-contained change)

---

## Phase 1: Preparation & Verification (Tasks 1-2)

### Task 1.1: Verify Existing Consolidated Plugins

**Objective**: Confirm that `system-stats.py`, `connectivity.py`, and `battery.py` are already implemented and functional in the working directory.

**Prerequisite**: None

**Steps**:
1. Check that `~/.config/sketchybar/plugins/system-stats.py` exists and is executable
2. Check that `~/.config/sketchybar/plugins/connectivity.py` exists and is executable
3. Check that `~/.config/sketchybar/plugins/battery.py` exists and is executable
4. Run each plugin independently: `python3 system-stats.py`, `python3 connectivity.py`, `python3 battery.py`
5. Verify output format (JSON or plain text) is valid

**Verification Criteria**:
- ✅ All 3 plugins exist and are executable (`ls -la plugins/system-stats.py`)
- ✅ No import errors when run individually
- ✅ Output is valid and non-empty
- ✅ All dependencies are installed (psutil, etc.)

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
python3 ~/.config/sketchybar/plugins/system-stats.py && echo "✓ system-stats"
python3 ~/.config/sketchybar/plugins/connectivity.py && echo "✓ connectivity"
python3 ~/.config/sketchybar/plugins/battery.py && echo "✓ battery"
```

---

### Task 1.2: Backup Current sketchybarrc and Old Plugins

**Objective**: Create a backup of the current configuration before making changes, ensuring rollback is possible.

**Prerequisite**: Task 1.1 completed

**Steps**:
1. Create a backup directory: `mkdir -p ~/.config/sketchybar/backups/$(date +%Y%m%d_%H%M%S)`
2. Copy current `sketchybarrc` to backup: `cp ~/.config/sketchybar/sketchybarrc ~/.config/sketchybar/backups/`
3. Copy old plugins (if present) to backup: `cp plugins/cpu.py plugins/gpu.py plugins/ram.py plugins/wifi.py backup/` (if they exist)
4. Document the backup date and purpose in a `BACKUP_README.txt`

**Verification Criteria**:
- ✅ Backup directory exists with timestamp
- ✅ `sketchybarrc` backup is present and readable
- ✅ Old plugin backups are present (if they existed)
- ✅ Backup is confirmed readable and valid

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
ls -la ~/.config/sketchybar/backups/
cat ~/.config/sketchybar/backups/sketchybarrc | head -5
```

---

## Phase 2: Configuration Update (Tasks 2-3)

### Task 2.1: Update sketchybarrc — Remove Old Plugin References

**Objective**: Delete all references to old plugins (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`) from `sketchybarrc`.

**Prerequisite**: Task 1.2 completed

**Steps**:
1. Open `~/.config/sketchybar/sketchybarrc` in an editor
2. Search for references to old plugins:
   - `cpu.py` or `cpu` bar item
   - `gpu.py` or `gpu` bar item
   - `ram.py` or `ram` bar item
   - `wifi.py` or `wifi` bar item
3. Delete or comment out those lines
4. Verify the file is still valid shell syntax (no syntax errors)

**Verification Criteria**:
- ✅ No references to `cpu.py`, `gpu.py`, `ram.py`, or `wifi.py` remain
- ✅ `bash -n sketchybarrc` passes (syntax check)
- ✅ Commented-out lines are marked with `# [DEPRECATED]` for clarity

**Estimated Effort**: 10 minutes

**Verification Command**:
```bash
bash -n ~/.config/sketchybar/sketchybarrc && echo "✓ Syntax valid"
grep -i "cpu\.py\|gpu\.py\|ram\.py\|wifi\.py" ~/.config/sketchybar/sketchybarrc || echo "✓ No old references"
```

---

### Task 2.2: Update sketchybarrc — Add Consolidated Plugin References

**Objective**: Add bar item references to the 3 consolidated plugins and configure their display options.

**Prerequisite**: Task 2.1 completed

**Steps**:
1. Open `~/.config/sketchybar/sketchybarrc`
2. Add bar items for `system-stats.py`:
   ```bash
   sketchybar -m \
       --add item system_stats left \
       --set system_stats icon.drawing=off \
       --set system_stats label.drawing=on \
       --set system_stats script="$PLUGIN_DIR/system-stats.py" \
       --set system_stats update_freq=2
   ```
3. Add bar items for `connectivity.py`:
   ```bash
   --add item connectivity left \
   --set connectivity icon.drawing=off \
   --set connectivity label.drawing=on \
   --set connectivity script="$PLUGIN_DIR/connectivity.py" \
   --set connectivity update_freq=5
   ```
4. Add/update bar items for `battery.py`:
   ```bash
   --add item battery right \
   --set battery icon.drawing=off \
   --set battery label.drawing=on \
   --set battery script="$PLUGIN_DIR/battery.py" \
   --set battery update_freq=10
   ```
5. Verify the file is syntactically valid

**Verification Criteria**:
- ✅ Bar items for `system_stats`, `connectivity`, and `battery` are present
- ✅ Each bar item references the correct plugin file
- ✅ Update frequencies are set (system-stats: 2-5s, connectivity: 5-10s, battery: 10-30s)
- ✅ `bash -n sketchybarrc` passes

**Estimated Effort**: 15 minutes

**Verification Command**:
```bash
bash -n ~/.config/sketchybar/sketchybarrc && echo "✓ Syntax valid"
grep "system-stats.py\|connectivity.py\|battery.py" ~/.config/sketchybar/sketchybarrc
```

---

## Phase 3: Metrics Verification (Tasks 3-5)

### Task 3.1: Verify CPU Metric in Sketchybar

**Objective**: Confirm CPU usage metric displays correctly in the sketchybar UI and updates in real-time.

**Prerequisite**: Task 2.2 completed

**Steps**:
1. Reload sketchybar: `sketchybar --reload` or `pkill -f sketchybar && sleep 1 && open -a Sketchybar`
2. Check that CPU metric appears in the bar
3. Trigger CPU load: `stress-ng --cpu 1 --timeout 15s` (or `yes > /dev/null &` for 10 seconds)
4. Observe CPU metric increases above 50% during load
5. After load ends, observe CPU metric decreases back to idle levels
6. Verify no console errors: `sketchybar --verbose` (check system logs)

**Verification Criteria**:
- ✅ CPU metric is visible in the sketchybar
- ✅ CPU metric shows a reasonable idle value (typically 1-10%)
- ✅ CPU metric increases to >50% under load
- ✅ CPU metric updates every 2-5 seconds (real-time)
- ✅ No subprocess errors in sketchybar logs

**Estimated Effort**: 10 minutes

**Verification Command**:
```bash
# Watch CPU metric in bar while running stress test
stress-ng --cpu 1 --timeout 15s &
sleep 2 && top -l 1 | grep "CPU usage"
```

---

### Task 3.2: Verify GPU Metric in Sketchybar

**Objective**: Confirm GPU utilization metric displays correctly, with expected 0% behavior when idle.

**Prerequisite**: Task 3.1 completed

**Steps**:
1. Check that GPU metric appears in the bar
2. With no GPU-heavy processes running, verify GPU shows 0% or "Idle"
3. Open Activity Monitor or run `gpu_stats` tool to confirm GPU is actually idle
4. (Optional) Run a GPU-heavy app (video player, 3D game) and observe GPU metric increase
5. Verify GPU metric returns to 0% after GPU load ends

**Verification Criteria**:
- ✅ GPU metric is visible in the sketchybar
- ✅ GPU shows 0% when system is idle (EXPECTED BEHAVIOR)
- ✅ GPU metric updates reflect actual GPU load if heavy app runs
- ✅ No errors when GPU monitoring tool is unavailable (graceful fallback to "N/A")

**Estimated Effort**: 10 minutes

**Verification Command**:
```bash
# Verify GPU is idle and metric shows 0%
sysctl hw.model
# Check Activity Monitor GPU tab confirms no GPU load
```

---

### Task 3.3: Verify RAM Metric in Sketchybar

**Objective**: Confirm RAM usage metric displays both percentage and absolute values correctly.

**Prerequisite**: Task 3.2 completed

**Steps**:
1. Check that RAM metric appears in the bar
2. Verify output format includes percentage and used/total (e.g., "42% (8GB/16GB)")
3. Trigger memory load: `python3 -c "x = [0] * 100_000_000; input()"` (allocate ~400MB, then wait)
4. Observe RAM metric increase
5. Stop the memory allocation and verify RAM metric decreases
6. Check that memory is accurately reported vs Activity Monitor

**Verification Criteria**:
- ✅ RAM metric displays percentage
- ✅ RAM metric displays used/total memory in GB
- ✅ RAM metric updates when memory allocation changes
- ✅ Values align with Activity Monitor or `top` output (within ±5%)
- ✅ No errors on metric collection

**Estimated Effort**: 10 minutes

**Verification Command**:
```bash
# Check RAM metric format
python3 ~/.config/sketchybar/plugins/system-stats.py | grep -i ram
# Compare with system
vm_stat | grep "Pages free"
```

---

### Task 3.4: Verify WiFi/Connectivity Metric in Sketchybar

**Objective**: Confirm WiFi status and signal strength display correctly.

**Prerequisite**: Task 3.3 completed

**Steps**:
1. Check that connectivity metric appears in the bar
2. Verify WiFi network name (SSID) or status is displayed (e.g., "Connected: MyWiFi" or "▄▅")
3. Verify signal strength is displayed (bars, percentage, or other indicator)
4. Change WiFi network or disconnect and reconnect to trigger metric update
5. Observe metric reflects new network name or "Disconnected"
6. Verify no errors when WiFi connection is unavailable

**Verification Criteria**:
- ✅ WiFi status is visible in the sketchybar
- ✅ Connected network name (SSID) is displayed or connection status shown
- ✅ Signal strength indicator is displayed (bars or percentage)
- ✅ Metric updates when WiFi connection changes
- ✅ Graceful display (e.g., "No WiFi" or "—") when disconnected, no errors

**Estimated Effort**: 10 minutes

**Verification Command**:
```bash
# Check connectivity metric
python3 ~/.config/sketchybar/plugins/connectivity.py
# Compare with system WiFi status
airport -I | grep -i "ssid\|lastTxRate"
```

---

### Task 3.5: Verify Battery Metric in Sketchybar

**Objective**: Confirm battery percentage and health status display correctly.

**Prerequisite**: Task 3.4 completed

**Steps**:
1. Check that battery metric appears in the bar
2. Verify battery percentage is displayed correctly (should match System Preferences → Battery)
3. Verify battery health status is displayed if available (Good, Normal, Replace Soon, etc.)
4. Verify charging status shows when plugged in (e.g., "78% Charging")
5. Verify no errors when battery info is unavailable (desktop systems)

**Verification Criteria**:
- ✅ Battery percentage is visible and accurate
- ✅ Battery percentage matches System Preferences (±2%)
- ✅ Health status displayed if available (or gracefully omitted if not)
- ✅ Charging status shown when AC adapter connected
- ✅ Graceful fallback for systems without battery (e.g., "AC Only")

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
# Check battery metric
python3 ~/.config/sketchybar/plugins/battery.py
# Compare with system
pmset -g batt | grep -i "Battery\|Charging"
```

---

## Phase 4: File Cleanup & Git Tracking (Tasks 4-5)

### Task 4.1: Delete Old Plugin Files from Disk

**Objective**: Remove old fragmented plugins from the filesystem since they're now consolidated.

**Prerequisite**: Tasks 3.1-3.5 completed and all metrics verified

**Steps**:
1. Verify old plugins still exist: `ls -la ~/.config/sketchybar/plugins/{cpu,gpu,ram,wifi}.py`
2. Delete each old plugin:
   ```bash
   rm ~/.config/sketchybar/plugins/cpu.py
   rm ~/.config/sketchybar/plugins/gpu.py
   rm ~/.config/sketchybar/plugins/ram.py
   rm ~/.config/sketchybar/plugins/wifi.py
   ```
3. Verify they are deleted: `ls ~/.config/sketchybar/plugins/` (should NOT list them)
4. Confirm consolidated plugins still exist:
   ```bash
   ls -la ~/.config/sketchybar/plugins/{system-stats,connectivity,battery}.py
   ```

**Verification Criteria**:
- ✅ Old plugins (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`) are deleted
- ✅ Consolidated plugins (`system-stats.py`, `connectivity.py`, `battery.py`) still exist
- ✅ Sketchybar continues to display all metrics correctly after deletion

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
ls ~/.config/sketchybar/plugins/cpu.py 2>&1 | grep "No such file" && echo "✓ cpu.py deleted"
ls ~/.config/sketchybar/plugins/system-stats.py && echo "✓ system-stats.py exists"
```

---

### Task 4.2: Commit Git Changes — Delete Old Plugins

**Objective**: Stage and commit the deletion of old plugins to git history.

**Prerequisite**: Task 4.1 completed

**Steps**:
1. Navigate to sketchybar directory: `cd ~/.config/sketchybar`
2. Check git status: `git status`
3. Stage the deleted files: `git add -A` (will stage deletions)
4. Verify deletions are staged: `git status` (should show "deleted:" entries)
5. Commit with descriptive message:
   ```bash
   git commit -m "Consolidate plugins: merge scattered metrics into 3 focused plugins

   - Remove cpu.py, gpu.py, ram.py → merged into system-stats.py
   - Remove wifi.py → merged into connectivity.py
   - Update sketchybarrc to reference consolidated plugins
   - Reduce subprocess overhead from 9+ → 3 (66% reduction)
   - Subprocess count now: system-stats, connectivity, battery only
   - Old files recoverable via git show HEAD~1:plugins/{filename}
   
   All metrics verified in real sketchybar environment:
   ✓ CPU usage, GPU utilization, RAM metrics
   ✓ WiFi status and signal strength
   ✓ Battery percentage and health status
   ✓ No console errors or regressions"
   ```

**Verification Criteria**:
- ✅ Git commit is created successfully
- ✅ Commit message is clear and descriptive
- ✅ Git log shows the commit: `git log -1 --oneline`
- ✅ Old files are recoverable: `git show HEAD~1:plugins/cpu.py` (should work)

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
git log -1 --stat  # Verify commit deleted old plugins
git show HEAD~1:plugins/cpu.py | head -5  # Verify old file recoverable
```

---

## Phase 5: Documentation & Finalization (Tasks 5-6)

### Task 5.1: Update README.md with Consolidated Architecture

**Objective**: Document the new plugin consolidation structure and metric ownership.

**Prerequisite**: Task 4.2 completed

**Steps**:
1. Open or create `~/.config/sketchybar/README.md`
2. Add section: **Plugin Architecture**
   ```markdown
   ## Plugin Architecture

   ### Consolidated Plugins (v2.0)

   Sketchybar plugins are consolidated by domain to reduce subprocess overhead and clarify metric ownership.

   #### system-stats.py
   - **Metrics**: CPU usage, GPU utilization, RAM usage
   - **Update Frequency**: 2-5 seconds
   - **Dependencies**: psutil
   - **Description**: Collects system resource metrics in a single subprocess call

   #### connectivity.py
   - **Metrics**: WiFi status, signal strength
   - **Update Frequency**: 5-10 seconds
   - **Dependencies**: airport (macOS) or iwconfig (Linux)
   - **Description**: Monitors WiFi connectivity and signal quality

   #### battery.py
   - **Metrics**: Battery percentage, health status
   - **Update Frequency**: 10-30 seconds
   - **Dependencies**: pmset (macOS) or /sys/class/power_supply (Linux)
   - **Description**: Tracks battery status and charging state

   ### Benefits of Consolidation
   - **Reduced Subprocess Overhead**: From 9+ plugins → 3 (66% reduction)
   - **Clear Metric Ownership**: Each plugin has a defined domain (system, connectivity, power)
   - **Easier Maintenance**: Related metrics in one file; easier to debug and update
   - **Better Error Isolation**: Plugin failures don't cascade across unrelated metrics
   ```

3. Add section: **Metric Definitions**
   ```markdown
   ## Metric Definitions

   ### CPU Usage
   - Definition: Percentage of CPU cores in active use
   - Range: 0-100%
   - Idle Expectation: 1-10% (varies by system)
   - Update Trigger: Every 2-5 seconds

   ### GPU Utilization
   - Definition: Percentage of GPU VRAM/compute in active use
   - Range: 0-100%
   - **Idle Behavior: 0% is EXPECTED when no GPU-heavy apps running**
   - Update Trigger: Every 2-5 seconds

   ### RAM Usage
   - Definition: Percentage and absolute memory in use
   - Format: "42% (8GB/16GB)"
   - Update Trigger: Every 2-5 seconds

   ### WiFi Status
   - Definition: Current WiFi network and connection state
   - Format: "Connected: MyWiFi" or "▄▅" (signal bars)
   - Update Trigger: Every 5-10 seconds

   ### Battery
   - Definition: Battery percentage and health status
   - Format: "78% (Good)" or "Charging 42%"
   - Update Trigger: Every 10-30 seconds
   ```

4. Add section: **Troubleshooting**
   ```markdown
   ## Troubleshooting

   ### GPU Shows 0% Always
   This is **expected behavior** when no GPU-heavy apps are running. GPU idle = 0% utilization.
   - To verify: Open Activity Monitor → GPU tab → confirm no GPU load
   - To test: Run a video player or 3D game → GPU should increase to 10-30%

   ### Metrics Not Updating
   - Check plugin is executable: `ls -la ~/.config/sketchybar/plugins/system-stats.py`
   - Run plugin manually: `python3 ~/.config/sketchybar/plugins/system-stats.py`
   - Check logs: `tail -f ~/.config/sketchybar/logs/system-stats.log`
   - Restart sketchybar: `pkill -f sketchybar && open -a Sketchybar`

   ### WiFi Metric Shows "—"
   - Check WiFi is connected: `airport -I | grep SSID`
   - Verify airport tool is available: `which airport`
   - Check logs: `tail ~/.config/sketchybar/logs/connectivity.log`
   ```

5. Verify README is readable and well-formatted

**Verification Criteria**:
- ✅ README.md includes Plugin Architecture section
- ✅ All 3 plugins are documented with metrics and update frequency
- ✅ Metric definitions are clear and include GPU 0% behavior note
- ✅ Troubleshooting section addresses common issues
- ✅ README is readable and properly formatted (GitHub Markdown compatible)

**Estimated Effort**: 15 minutes

---

### Task 5.2: Verify No Broken References in sketchybarrc

**Objective**: Final check that sketchybarrc has no references to deleted old plugins and all new plugins are correctly referenced.

**Prerequisite**: Task 5.1 completed

**Steps**:
1. Run syntax check: `bash -n ~/.config/sketchybar/sketchybarrc`
2. Search for any remaining old plugin references:
   ```bash
   grep -i "cpu\.py\|gpu\.py\|ram\.py\|wifi\.py" ~/.config/sketchybar/sketchybarrc || echo "✓ No old references"
   ```
3. Verify all new plugins are referenced:
   ```bash
   grep "system-stats.py" ~/.config/sketchybar/sketchybarrc && echo "✓ system-stats referenced"
   grep "connectivity.py" ~/.config/sketchybar/sketchybarrc && echo "✓ connectivity referenced"
   grep "battery.py" ~/.config/sketchybar/sketchybarrc && echo "✓ battery referenced"
   ```
4. Reload sketchybar one final time and verify all metrics appear: `sketchybar --reload`

**Verification Criteria**:
- ✅ No syntax errors in sketchybarrc
- ✅ No references to old plugins (cpu.py, gpu.py, ram.py, wifi.py)
- ✅ All 3 new plugins referenced in sketchybarrc
- ✅ Sketchybar loads without console errors
- ✅ All metrics visible and updating in bar

**Estimated Effort**: 5 minutes

**Verification Command**:
```bash
bash -n ~/.config/sketchybar/sketchybarrc && echo "✓ Syntax valid"
grep -E "system-stats|connectivity|battery" ~/.config/sketchybar/sketchybarrc | wc -l  # Should be ≥3
```

---

## Phase 6: Final Acceptance Verification (Task 6)

### Task 6.1: 5-Minute Real-World Observation Test

**Objective**: Confirm all metrics display correctly and update in real-time over a sustained observation period.

**Prerequisite**: All previous tasks completed

**Steps**:
1. Start fresh sketchybar session (if not already running): `open -a Sketchybar`
2. Observe the bar for 5+ minutes, noting:
   - **System Metrics**: CPU fluctuates naturally (1-20% idle), GPU stays 0%, RAM stable
   - **Connectivity**: WiFi network name visible, signal bars update
   - **Battery**: Percentage stable (or decreasing if on battery), health status shown
   - **Update Frequency**: Each metric updates at expected interval
   - **Errors**: No console errors, no flashing/flickering, no crashes
3. Trigger state changes to verify metric updates:
   - CPU: Run `yes > /dev/null &` for 10s → observe CPU spike → kill with Ctrl+C
   - WiFi: Disconnect and reconnect → observe connectivity metric update
   - RAM: Open a large app (browser, IDE) → observe RAM increase
4. Document observations in a `VERIFICATION_LOG.txt`:
   ```
   Date: 2026-03-08
   Duration: 5+ minutes
   
   ✓ CPU metric: Updates every 2-5s, accurately reflects load
   ✓ GPU metric: Shows 0% (idle), expected behavior
   ✓ RAM metric: Displays 42% (8GB/16GB), accurate
   ✓ WiFi metric: Shows "Connected: MyWiFi", signal bars visible
   ✓ Battery metric: Shows 78% (Good), accurate
   ✓ No console errors
   ✓ No sketchybar crashes
   ```

**Verification Criteria**:
- ✅ All metrics visible and correctly formatted
- ✅ All metrics update at expected frequencies (CPU 2-5s, WiFi 5-10s, Battery 10-30s)
- ✅ Metrics respond correctly to system state changes (CPU load, network switch, RAM allocation)
- ✅ No console errors, warnings, or crashes
- ✅ No subprocess failures or timeouts
- ✅ Observation log created documenting test results

**Estimated Effort**: 10 minutes (mostly passive observation)

---

## Task Summary Table

| Phase | Task | Title | Effort | Status |
|-------|------|-------|--------|--------|
| 1 | 1.1 | Verify Existing Consolidated Plugins | 5m | Verification |
| 1 | 1.2 | Backup Current Config | 5m | Verification |
| 2 | 2.1 | Remove Old Plugin References from sketchybarrc | 10m | Implementation |
| 2 | 2.2 | Add Consolidated Plugin References to sketchybarrc | 15m | Implementation |
| 3 | 3.1 | Verify CPU Metric | 10m | Verification |
| 3 | 3.2 | Verify GPU Metric | 10m | Verification |
| 3 | 3.3 | Verify RAM Metric | 10m | Verification |
| 3 | 3.4 | Verify WiFi/Connectivity Metric | 10m | Verification |
| 3 | 3.5 | Verify Battery Metric | 5m | Verification |
| 4 | 4.1 | Delete Old Plugin Files | 5m | Implementation |
| 4 | 4.2 | Commit Git Changes | 5m | Implementation |
| 5 | 5.1 | Update README.md | 15m | Documentation |
| 5 | 5.2 | Verify No Broken References | 5m | Verification |
| 6 | 6.1 | 5-Minute Real-World Test | 10m | Verification |
| | **TOTAL** | | **120 min** | |

---

## Rollback Procedure (If Needed)

If any task fails or introduces regressions:

```bash
# 1. Identify which task failed
# 2. Restore from backup if needed
cp ~/.config/sketchybar/backups/*/sketchybarrc ~/.config/sketchybar/sketchybarrc

# 3. Revert git commits
git revert HEAD
git revert HEAD~1

# 4. Restore old plugins from git history
git show HEAD~2:plugins/cpu.py > ~/.config/sketchybar/plugins/cpu.py
git show HEAD~2:plugins/gpu.py > ~/.config/sketchybar/plugins/gpu.py
git show HEAD~2:plugins/ram.py > ~/.config/sketchybar/plugins/ram.py
git show HEAD~2:plugins/wifi.py > ~/.config/sketchybar/plugins/wifi.py

# 5. Restart sketchybar
pkill -f sketchybar
sleep 1
open -a Sketchybar

# 6. Verify metrics reappear
```

---

## Acceptance Checklist

- [ ] Task 1.1: Consolidated plugins verified ✓
- [ ] Task 1.2: Backup created ✓
- [ ] Task 2.1: Old references removed from sketchybarrc ✓
- [ ] Task 2.2: Consolidated references added to sketchybarrc ✓
- [ ] Task 3.1: CPU metric verified ✓
- [ ] Task 3.2: GPU metric verified ✓
- [ ] Task 3.3: RAM metric verified ✓
- [ ] Task 3.4: WiFi metric verified ✓
- [ ] Task 3.5: Battery metric verified ✓
- [ ] Task 4.1: Old plugins deleted from disk ✓
- [ ] Task 4.2: Git commit created ✓
- [ ] Task 5.1: README updated with architecture ✓
- [ ] Task 5.2: No broken references in sketchybarrc ✓
- [ ] Task 6.1: 5-minute observation test passed ✓

**All tasks completed**: Ready for sdd-archive.
