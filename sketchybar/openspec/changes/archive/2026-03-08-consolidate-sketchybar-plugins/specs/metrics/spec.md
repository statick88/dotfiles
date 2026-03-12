# Delta Specification: Consolidated Sketchybar Plugins

**Change**: consolidate-sketchybar-plugins  
**Domain**: metrics (system-stats, connectivity, battery)  
**Scope**: Plugin consolidation from 9 fragmented files → 3 focused plugins

---

## ADDED Requirements

### Requirement: system-stats.py Consolidates CPU, GPU, RAM Metrics

The `plugins/system-stats.py` plugin MUST collect and output CPU usage, GPU utilization, and RAM usage metrics in a single subprocess call.

**Rationale**: Previously spread across `cpu.py`, `gpu.py`, `ram.py` (3 separate subprocesses). Consolidation reduces process overhead and clarifies single source of truth for system metrics.

#### Scenario: CPU Usage Metric Displays Correctly

- GIVEN the sketchybar bar is running with consolidated `system-stats.py` configured
- WHEN the system executes a CPU-bound workload (e.g., `stress-ng --cpu 1` for 10 seconds)
- THEN the CPU metric in the bar updates in real-time, showing usage > 50%
- AND the metric updates every 2-5 seconds (near real-time frequency)
- AND no subprocess errors are logged

#### Scenario: GPU Shows 0% When Idle (Expected Behavior)

- GIVEN the system has no GPU-heavy processes running
- WHEN `system-stats.py` is called
- THEN GPU utilization displays as `0%`
- AND this is treated as correct behavior, not a failure state
- AND Activity Monitor or `gpu_stats` confirms no GPU load

#### Scenario: RAM Usage Displays Percentage and Absolute Values

- GIVEN the sketchybar bar is running
- WHEN the system has memory in use
- THEN the RAM metric displays both percentage (e.g., `42%`) AND absolute values (e.g., `8GB / 16GB`)
- AND updates reflect changes when new processes start/stop

#### Scenario: No Subprocess Errors on Plugin Execution

- GIVEN `plugins/system-stats.py` is called by sketchybarrc
- WHEN the plugin executes
- THEN stderr is clean (no Python exceptions, import errors, or undefined variables)
- AND the plugin returns valid JSON or plain text output compatible with sketchybar bar items

---

### Requirement: connectivity.py Consolidates WiFi Monitoring

The `plugins/connectivity.py` plugin MUST collect and output WiFi status and signal strength metrics.

**Rationale**: Previously scattered in `wifi.py` and potentially mixed with other connectivity concerns. Consolidation clarifies connectivity as a single responsibility domain.

#### Scenario: WiFi Status Displays Current Network

- GIVEN the system is connected to a WiFi network
- WHEN `connectivity.py` is called
- THEN the output includes the current network SSID or connection status
- AND updates when WiFi network changes

#### Scenario: WiFi Signal Strength Displays Correctly

- GIVEN WiFi is active and connected
- WHEN the plugin executes
- THEN signal strength is displayed (e.g., bars, percentage, or dBm)
- AND the metric updates when signal fluctuates
- AND no errors occur when querying WiFi metrics

---

### Requirement: battery.py Dedicated to Battery Metrics

The `plugins/battery.py` plugin MUST collect and output battery percentage and health status.

**Rationale**: Battery is a separate concern from system metrics and connectivity. Dedicated plugin allows independent update frequency and failure handling.

#### Scenario: Battery Percentage Displays Correctly

- GIVEN the system is running on battery or has a battery
- WHEN `plugins/battery.py` is called
- THEN battery percentage is displayed (e.g., `78%`)
- AND updates reflect battery drain/charge cycles in real-time

#### Scenario: Battery Health Status Shows When Available

- GIVEN the system reports battery health information
- WHEN the plugin executes
- THEN health status is included (e.g., "Good", "Normal", "Replace Soon")
- AND the metric is optional; no error if health data is unavailable

---

### Requirement: sketchybarrc References Consolidated Plugins

The bar item configuration in `sketchybarrc` MUST reference only the 3 consolidated plugins (`system-stats.py`, `connectivity.py`, `battery.py`) and MUST NOT reference deleted plugins.

#### Scenario: CPU Bar Item References system-stats.py

- GIVEN sketchybarrc is loaded
- WHEN the bar attempts to render the CPU metric
- THEN the bar item script references `plugins/system-stats.py`, not `plugins/cpu.py`
- AND no "file not found" or "command not found" error occurs

#### Scenario: WiFi Bar Item References connectivity.py

- GIVEN sketchybarrc is loaded
- WHEN the bar attempts to render WiFi status
- THEN the bar item script references `plugins/connectivity.py`, not `plugins/wifi.py`
- AND the metric displays without errors

#### Scenario: RAM Bar Item References system-stats.py

- GIVEN sketchybarrc is loaded
- WHEN the bar attempts to render the RAM metric
- THEN the bar item script references `plugins/system-stats.py`, not `plugins/ram.py`
- AND the metric displays alongside CPU in the same subprocess output

---

### Requirement: No Subprocess Overhead Increase

The consolidation MUST NOT increase subprocess overhead; subprocess count MUST decrease from 9+ plugins to 3.

#### Scenario: Fewer Subprocesses After Consolidation

- GIVEN the sketchybar bar is running with consolidated plugins
- WHEN monitoring system processes (e.g., `ps aux | grep python`)
- THEN the number of python plugin subprocesses is ≤ 3 (for system-stats, connectivity, battery)
- AND this is fewer than or equal to the previous count of 9+

---

## MODIFIED Requirements

### Requirement: Old Plugin Files Removed from Disk

The old fragmented plugins (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`) MUST be deleted from the disk and removed from git history.

**Previously**: 9+ plugin files scattered in `plugins/` directory, each handling one metric.  
**Now**: 3 consolidated plugins, old files deleted.

#### Scenario: cpu.py, gpu.py, ram.py No Longer Exist

- GIVEN the consolidation is complete
- WHEN `ls plugins/` is executed
- THEN `cpu.py`, `gpu.py`, `ram.py` do NOT appear in the listing
- AND attempting to call `plugins/cpu.py` results in "file not found"

#### Scenario: wifi.py Removed

- GIVEN the consolidation is complete
- WHEN `ls plugins/` is executed
- THEN `wifi.py` does NOT appear in the listing
- AND connectivity metrics come from `connectivity.py` only

#### Scenario: Git History Reflects Deletion

- GIVEN the consolidation commits are applied
- WHEN `git log --diff-filter=D --summary` is executed
- THEN deleted files (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py`) are logged as deleted
- AND files can still be recovered via `git show HEAD~N:plugins/{filename}`

---

### Requirement: README Documentation Updated

The `README.md` (if present) or plugin documentation MUST be updated to describe the new consolidated architecture.

**Previously**: Documentation scattered or missing for individual plugins.  
**Now**: Clear documentation of plugin consolidation and metric ownership.

#### Scenario: README Documents Plugin Structure

- GIVEN README.md is present in the project
- WHEN README is read
- THEN it documents the 3 consolidated plugins: system-stats.py, connectivity.py, battery.py
- AND it explains the metrics each plugin provides
- AND it explains why consolidation reduces overhead

#### Scenario: README Defines Metric Boundaries

- GIVEN README is present
- WHEN someone reads the "Metric Ownership" section
- THEN it clearly states:
  - **system-stats.py**: CPU, GPU, RAM
  - **connectivity.py**: WiFi status and signal strength
  - **battery.py**: Battery percentage and health
- AND it explains the rationale for each boundary

---

## REMOVED Requirements

### Requirement: Individual Plugin Separation (cpu.py, gpu.py, ram.py, wifi.py)

The previous requirement to maintain separate plugin files for each metric is REMOVED.

**Reason**: Consolidation into 3 focused plugins improves maintainability, reduces subprocess overhead, and clarifies metric ownership.

---

## Error Handling & Edge Cases

### Requirement: Plugin Failures Do Not Cascade

If one consolidated plugin fails (e.g., `system-stats.py` crashes), the failure MUST NOT affect other plugins (`connectivity.py`, `battery.py`).

#### Scenario: system-stats.py Failure Does Not Affect Battery

- GIVEN `system-stats.py` fails with an exception
- WHEN the bar updates
- THEN the CPU, GPU, and RAM metrics may display errors or stale values
- AND the battery metric from `battery.py` continues to update normally
- AND no cascading error affects the entire bar

---

### Requirement: Graceful Degradation on Missing System Tools

If system tools required by a plugin are unavailable (e.g., GPU stats tool not installed), the plugin MUST gracefully degrade.

#### Scenario: GPU Stats Tool Not Available

- GIVEN the system lacks GPU monitoring tools (e.g., `gpu_stats` or equivalent)
- WHEN `system-stats.py` executes
- THEN GPU utilization displays as `N/A` or `—` (not an error)
- AND CPU and RAM metrics still update correctly
- AND no exception is raised

---

## Acceptance Criteria Mapping

| Acceptance Criterion | Covered By Scenario |
|---------------------|-------------------|
| All 3 consolidated plugins present and executable | CPU/GPU/RAM/WiFi/Battery scenarios |
| CPU metric displays correctly (real-time) | CPU Usage Metric Displays Correctly |
| GPU shows 0% when idle (expected behavior) | GPU Shows 0% When Idle |
| RAM displays % and used/total | RAM Usage Displays Percentage |
| WiFi status and signal display | WiFi Status / Signal Strength scenarios |
| Battery % displays | Battery Percentage Displays Correctly |
| Old plugin files removed from disk | cpu.py / gpu.py / ram.py / wifi.py Removed |
| Sketchybarrc references consolidated plugins only | CPU/WiFi/RAM Bar Item Reference scenarios |
| No console errors on load | No Subprocess Errors scenario |
| Git history clean (deleted files committed) | Git History Reflects Deletion |
| design.md documents architecture | (Covered in design.md) |
| Plugins tested in real sketchybar environment | (Covered in tasks.md verification) |

---

## Summary

**Spec Domains**: metrics/system-stats, metrics/connectivity, metrics/battery  
**Requirements Added**: 10 core requirements + edge cases  
**Scenarios Defined**: 17 total scenarios (happy path + edge cases)  
**Coverage**:
- ✅ Happy paths: CPU, GPU, RAM, WiFi, Battery metrics
- ✅ Edge cases: GPU 0% idle behavior, missing tools, plugin failures
- ✅ Error handling: Graceful degradation, isolated failures
- ✅ Integration: Sketchybarrc references, no cascading failures

**Next Phase**: Ready for design.md (architecture decisions and system design).
