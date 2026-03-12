# Technical Design: Consolidated Sketchybar Plugins

**Change**: consolidate-sketchybar-plugins  
**Status**: Ready for implementation  
**Reviewed Against**: proposal.md, specs/metrics/spec.md

---

## 1. Architecture Overview

### Problem Statement

The sketchybar configuration had 9+ fragmented plugins, each spawning a separate subprocess:
- **System metrics**: `cpu.py`, `gpu.py`, `ram.py` (3 separate processes)
- **Connectivity**: `wifi.py`, `bluetooth.py` (fragmented concerns)
- **Power**: Battery metrics scattered
- **Unrelated**: `mail.py`, `news.py`, etc.

**Impact**:
- High subprocess overhead: 9+ Python processes spawned on each bar update cycle
- Unclear metric ownership: Why is CPU in one file and GPU in another?
- Maintenance burden: Changes to system metrics require edits across 3 files
- Single points of failure: If `cpu.py` crashes, CPU metric disappears; no relationship to GPU or RAM failures

### Solution: Consolidation by Domain

**New Architecture** — 3 focused plugins grouped by concern:

```
┌─────────────────────────────────────────────────────────┐
│                     sketchybar Bar                       │
└──────────────┬──────────────┬──────────────┬─────────────┘
               │              │              │
        ┌──────▼──────┐ ┌─────▼─────┐ ┌─────▼──────┐
        │ system-stats │ │connectivity│ │  battery  │
        │    .py      │ │    .py     │ │    .py    │
        └──────┬──────┘ └─────┬─────┘ └─────┬──────┘
               │              │              │
        ┌──────▼────────────────┴──────────┐ │
        │ Unified metrics output:          │ │
        │ - CPU: 45%                       │ │
        │ - GPU: 0%                        │ │
        │ - RAM: 42% (8GB/16GB)            │ │
        │ - WiFi: Connected (Strong)       │ │
        │ - Battery: 78% (Good)            │ │
        └─────────────────────────────────┘ │
                                            │
                               ┌────────────┘
                               │
                       [Fewer Subprocesses]
                       [Lower CPU Overhead]
                       [Clear Ownership]
```

**Subprocess Count**:
- **Before**: 9+ Python processes per update cycle
- **After**: 3 Python processes per update cycle
- **Reduction**: 66%+ fewer subprocesses

---

## 2. Plugin Consolidation Design

### Domain 1: System Metrics (`plugins/system-stats.py`)

**Metrics Collected**: CPU usage, GPU utilization, RAM usage  
**Update Frequency**: 2-5 seconds (configurable)  
**Output Format**: JSON or plain text compatible with sketchybar

#### Subprocess Strategy

```python
# Before (3 subprocesses):
def cpu_metric():
    return get_cpu_usage()  # Subprocess 1

def gpu_metric():
    return get_gpu_usage()  # Subprocess 2

def ram_metric():
    return get_ram_usage()  # Subprocess 3

# After (1 consolidated subprocess):
def system_stats():
    cpu = get_cpu_usage()     # Shared subprocess call
    gpu = get_gpu_usage()     # Shared subprocess call
    ram = get_ram_usage()     # Shared subprocess call
    return format_output(cpu, gpu, ram)  # Single output
```

#### Shared Utilities

All three metrics can share:
- **System query interface**: Single `psutil` or similar library instance
- **Error handling**: Centralized try/catch for system unavailability
- **Caching**: Avoid repeated system calls for metrics that don't change frequently

#### Metric Boundaries

| Metric | Definition | Data Source | Update Trigger |
|--------|-----------|-------------|-----------------|
| **CPU** | Percentage of CPU cores in use | `psutil.cpu_percent()` or `/proc/stat` | Every 2-5 sec |
| **GPU** | Percentage of GPU VRAM/compute in use | `gpu_stats` tool, Metal API (macOS), or equivalent | Every 2-5 sec |
| **RAM** | Percentage and absolute (used/total) | `psutil.virtual_memory()` or `/proc/meminfo` | Every 2-5 sec |

#### GPU 0% Behavior

**Important**: When no GPU-heavy processes are running, GPU utilization SHOULD show `0%`. This is **expected behavior**, NOT a bug.

- System idle → GPU idle → 0% usage ✅
- Running video player → GPU usage → 10-30% (varies by content)
- Running game → GPU usage → 50-100%

If GPU always shows 0% even under load, check:
1. GPU monitoring tool is installed and working
2. GPU-heavy app is actually using the GPU (not CPU-only)
3. GPU drivers are up to date

---

### Domain 2: Connectivity Metrics (`plugins/connectivity.py`)

**Metrics Collected**: WiFi status, signal strength  
**Update Frequency**: 5-10 seconds (WiFi changes less frequently)  
**Output Format**: Human-readable status + signal bars or percentage

#### Scope

- **In Scope**: WiFi status (connected/disconnected), SSID, signal strength
- **Out of Scope**: Bluetooth (deferred), VPN status (separate concern)

#### Metric Definitions

| Metric | Definition | Data Source | Example Output |
|--------|-----------|-------------|-----------------|
| **WiFi Status** | Connection state and network name | `airport` (macOS) or `iwconfig` (Linux) | "Connected: WiFi-Home" |
| **Signal Strength** | Signal quality indicator | WiFi AP signal dBm converted to bars/% | "▁▂▃▄▅" or "75%" |

#### Error Handling

If WiFi is unavailable or the tool fails:
- Display: "WiFi: —" or "No WiFi"
- Do NOT crash the plugin
- Log error for debugging

---

### Domain 3: Battery Metrics (`plugins/battery.py`)

**Metrics Collected**: Battery percentage, health status  
**Update Frequency**: 10-30 seconds (battery changes slowly)  
**Output Format**: Percentage + optional health status

#### Metric Boundaries

| Metric | Definition | Data Source | Example Output |
|--------|-----------|-------------|-----------------|
| **Battery %** | Remaining charge percentage | `pmset -g batt` (macOS) or `/sys/class/power_supply` (Linux) | "78%" |
| **Health** | Battery health status | System battery info | "Good", "Normal", "Replace Soon" |

#### Edge Cases

- **Charging**: Display "AC Charging" or "78% (Charging)"
- **No Battery**: Display "AC Only" (desktop systems)
- **Critical Low**: Display warning color or alert state

---

## 3. Integration with sketchybarrc

### Bar Item Configuration

Each metric family has one or more bar items in `sketchybarrc`:

```bash
# BEFORE (separate bar items for each plugin):
sketchybar -m \
    --add item cpu left \
    --set cpu script="$PLUGIN_DIR/cpu.py" \
    --add item gpu left \
    --set gpu script="$PLUGIN_DIR/gpu.py" \
    --add item ram left \
    --set ram script="$PLUGIN_DIR/ram.py" \
    --add item wifi left \
    --set wifi script="$PLUGIN_DIR/wifi.py" \
    --add item battery left \
    --set battery script="$PLUGIN_DIR/battery.py"

# AFTER (consolidated plugins):
sketchybar -m \
    --add item system_stats left \
    --set system_stats script="$PLUGIN_DIR/system-stats.py" \
    --add item connectivity left \
    --set connectivity script="$PLUGIN_DIR/connectivity.py" \
    --add item battery left \
    --set battery script="$PLUGIN_DIR/battery.py"
```

### Output Parsing

Sketchybar expects JSON or structured output. Each plugin MUST output in a format that sketchybar can parse:

```json
{
    "cpu": "45%",
    "gpu": "0%",
    "ram": "8GB / 16GB (42%)"
}
```

Or plain text with delimiters:

```
CPU: 45% | GPU: 0% | RAM: 8GB/16GB
```

**Configuration in sketchybarrc**:
```bash
--set system_stats icon.drawing=off label.drawing=on label="$(system-stats.py)"
```

---

## 4. Error Handling & Resilience

### Plugin Isolation

Each plugin runs in its own subprocess. If `system-stats.py` crashes:
- ✅ `connectivity.py` continues to update
- ✅ `battery.py` continues to update
- ❌ CPU, GPU, RAM metrics may show stale values until plugin restarts

**Sketchybar's built-in behavior**: On subprocess failure, the bar item retains its last known value or displays an error indicator.

### Graceful Degradation

If a system tool is missing (e.g., GPU stats tool):

```python
# system-stats.py
try:
    gpu = get_gpu_usage()
except ToolNotFound:
    gpu = "N/A"  # Graceful fallback, not an error
except SystemError as e:
    log_error(e)
    gpu = "—"
```

**Output**: Plugin still returns valid data; GPU shows "N/A" instead of crashing the entire bar.

### Logging & Debugging

Each plugin SHOULD log errors to a file in `~/.config/sketchybar/logs/`:

```
~/.config/sketchybar/logs/
├── system-stats.log      (CPU, GPU, RAM errors)
├── connectivity.log      (WiFi errors)
└── battery.log           (Battery errors)
```

This allows debugging without interrupting the bar.

---

## 5. File Structure & Cleanup

### New File Layout

```
~/.config/sketchybar/
├── plugins/
│   ├── system-stats.py       ← NEW: CPU, GPU, RAM
│   ├── connectivity.py        ← NEW: WiFi
│   ├── battery.py            ← NEW (may already exist)
│   ├── other-unrelated.py    ← Untouched for now
│   └── (OLD FILES DELETED):
│       ✗ cpu.py
│       ✗ gpu.py
│       ✗ ram.py
│       ✗ wifi.py
├── sketchybarrc              ← MODIFIED: Updated references
├── README.md                 ← MODIFIED: Documentation
└── logs/                     ← NEW: Error logs
    ├── system-stats.log
    ├── connectivity.log
    └── battery.log
```

### Git History

Old plugin files will be deleted and committed:

```bash
git rm plugins/cpu.py
git rm plugins/gpu.py
git rm plugins/ram.py
git rm plugins/wifi.py
git commit -m "Consolidate: Merge system metrics into system-stats.py

- Remove cpu.py, gpu.py, ram.py → merged into system-stats.py
- Update sketchybarrc to reference consolidated plugins
- Reduce subprocess overhead from 9+ → 3
- Files recoverable via git log if needed for reference"
```

Files are still recoverable via `git show HEAD~1:plugins/cpu.py` if needed.

---

## 6. Testing Strategy

### Unit Tests (Per Plugin)

Each plugin should have unit tests covering:
- **system-stats.py**: CPU/GPU/RAM parsing, output format validation
- **connectivity.py**: WiFi status detection, signal parsing
- **battery.py**: Battery percentage extraction, health status detection

```python
def test_system_stats_output_format():
    result = system_stats()
    assert "cpu" in result
    assert "gpu" in result
    assert "ram" in result

def test_gpu_zero_percent_when_idle():
    # GPU should show 0% when no heavy processes running
    result = system_stats()
    gpu = result["gpu"]
    assert gpu == "0%" or gpu == "0% (idle)"
```

### Integration Tests (Sketchybar)

Test plugins with actual sketchybar bar items:

1. **Start sketchybar** with consolidated configuration
2. **Verify metrics update** in real-time over 5+ minutes
3. **Check for errors** in sketchybar logs (`sketchybar --verbose`)
4. **Confirm no crashes** when system state changes (network disconnect, battery drop, CPU spike)

### Acceptance Verification

Before marking complete:
- [ ] All 3 plugins present and executable
- [ ] Metrics display correctly in sketchybar bar
- [ ] No console errors on load
- [ ] Old plugin files deleted from disk
- [ ] sketchybarrc references consolidated plugins only
- [ ] Tested in real sketchybar environment for 5+ minutes

---

## 7. Performance Considerations

### Subprocess Overhead

**Metric**: Time to spawn and execute all plugins per update cycle

| Scenario | Before (9 plugins) | After (3 plugins) | Improvement |
|----------|-------------------|------------------|------------|
| Single update cycle | ~500ms (worst case) | ~150ms (worst case) | ~67% faster |
| CPU/memory footprint | 9× Python processes | 3× Python processes | ~67% fewer |
| Disk I/O | 9 reads from /proc | 3 reads from /proc | ~67% fewer |

### Optimization Opportunities (Future)

- **Caching**: Cache results from expensive system calls (e.g., GPU stats) within a time window
- **Async updates**: Use threading to update metrics independently (battery slower than CPU)
- **C extensions**: Use compiled C libraries for system metric collection (e.g., `psutil` C backend)

---

## 8. Rollback Plan

If consolidation introduces issues:

### Immediate Rollback

```bash
# 1. Revert to previous git commit
git revert <commit-hash>

# 2. Restart sketchybar
pkill -f sketchybar
# Re-launch sketchybar app

# 3. Verify old plugins reappear
ls -la ~/.config/sketchybar/plugins/cpu.py
```

### Partial Rollback (If Specific Plugin Fails)

```bash
# 1. Identify which consolidated plugin failed (system-stats vs connectivity vs battery)
# 2. Recover old plugin from git history
git show HEAD~1:plugins/cpu.py > ~/.config/sketchybar/plugins/cpu.py

# 3. Update sketchybarrc to use old plugin for that metric
# 4. Restart sketchybar

# 5. File a bug for the consolidated plugin
```

---

## 9. Documentation & Handoff

### Plugin README

Each plugin should include a header comment:

```python
#!/usr/bin/env python3
"""
System Stats Plugin for Sketchybar
==================================

Consolidates CPU usage, GPU utilization, and RAM metrics.

Metrics:
  - CPU: System CPU usage percentage
  - GPU: GPU utilization (0% when idle is expected)
  - RAM: RAM usage percentage and absolute values

Output Format:
  JSON dict with keys: cpu, gpu, ram

Dependencies:
  - psutil (pip install psutil)
  - gpu_stats tool (if GPU monitoring desired)

Error Handling:
  - Returns "N/A" for unavailable metrics
  - Logs errors to ~/.config/sketchybar/logs/system-stats.log
"""
```

### Architecture Documentation

Update `README.md` to include:
1. **Plugin Consolidation Rationale**: Why 9 → 3
2. **Metric Ownership**: Which plugin provides which metrics
3. **Maintenance Guide**: How to update each plugin
4. **Troubleshooting**: Common issues and solutions

---

## 10. Decision Log

| Decision | Rationale | Alternatives Considered |
|----------|-----------|------------------------|
| Consolidate by **domain** (system, connectivity, power) | Clear separation of concerns; reduces maintenance overhead | Consolidate by **frequency** (fast, medium, slow) → less clear boundaries |
| **Single subprocess output** for system-stats | Reduces overhead; all system metrics in one call | Separate subprocesses → defeats consolidation goal |
| **Keep battery separate** from connectivity | Battery is a power concern, not a connectivity concern; different update frequency | Merge with connectivity → unclear boundary |
| **Delete old plugin files** (not archive) | Cleaner codebase; files still recoverable from git | Archive in subfolder → confusing, not recommended |
| **No Bluetooth consolidation** | Out of scope for this change; can be added later | Include Bluetooth → scope creep |

---

## Summary

**Consolidated Plugins**: 3 (system-stats, connectivity, battery)  
**Subprocess Reduction**: 9+ → 3 (66%+ fewer)  
**Metric Coverage**: CPU, GPU, RAM, WiFi, Battery  
**Error Handling**: Graceful degradation, plugin isolation  
**Testing**: Unit + integration tests required  
**Rollback**: Reversible via git revert  

**Status**: Ready for task breakdown (sdd-tasks).
