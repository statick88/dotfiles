# Proposal: Consolidate Scattered Sketchybar Plugins

## Intent

The sketchybar configuration had accumulated 9+ fragmented plugins, each handling a single metric or concern:
- `cpu.py`, `gpu.py`, `ram.py` → Scattered system metrics
- `wifi.py`, `bluetooth.py` → Split connectivity concerns
- `mail.py`, `news.py` → Unrelated feature plugins
- Plus others in various states of maintenance

**Problem**: Plugin fragmentation makes the codebase harder to maintain, increases subprocess overhead, and creates confusion about metric ownership. Each file is a single point of failure for an entire metric family.

**Solution**: Consolidate related plugins into 3 focused, single-responsibility plugins with clear boundaries.

## Scope

### In Scope
- Merge `cpu.py` + `gpu.py` + `ram.py` → `system-stats.py` (3 metrics, 1 source)
- Consolidate WiFi monitoring → `connectivity.py` (primary connectivity metrics)
- Dedicate `battery.py` (battery %, health status)
- Remove old fragmented plugins from disk and git history
- Update sketchybarrc bar item configuration to reference new plugins
- Verify all metrics display correctly in real-time sketchybar UI
- Document consolidated architecture and metric boundaries

### Out of Scope
- Bluetooth integration (deferred to future connectivity phase)
- Mail/news plugins (unrelated to system metrics; can be reimplemented separately)
- Refactoring remaining unrelated plugins (future consolidation pass)
- Performance optimization beyond subprocess reduction from fewer plugins

## Approach

**High-level strategy**:
1. **Identify metric families**: Group related metrics by domain (system, connectivity, power)
2. **Consolidate files**: Merge functions, share subprocess calls where possible
3. **Update bar config**: Modify sketchybarrc to call consolidated plugins instead of scattered ones
4. **Verify functionality**: Test each metric in real sketchybar to confirm display and updates
5. **Clean up**: Remove old plugin files and confirm git history is clean

**Architectural improvement**:
- **Before**: 9 files → each a separate process spawn, separate error handling, unclear ownership
- **After**: 3 files → grouped by concern, shared utilities, clear metric ownership, 66% fewer plugin files

## Affected Areas

| Area | Impact | Description |
|------|--------|-------------|
| `plugins/system-stats.py` | New | CPU usage, GPU utilization, RAM usage in one file |
| `plugins/connectivity.py` | New | WiFi status and signal strength |
| `plugins/battery.py` | New | Battery percentage and health status |
| `plugins/cpu.py` | Removed | Merged into system-stats.py |
| `plugins/gpu.py` | Removed | Merged into system-stats.py |
| `plugins/ram.py` | Removed | Merged into system-stats.py |
| `plugins/wifi.py` | Removed | Merged into connectivity.py |
| `sketchybarrc` | Modified | Updated bar items to reference consolidated plugins |
| `README.md` (if exists) | Modified | Document new plugin structure and metric ownership |

## Risks

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| Metrics display incorrectly after consolidation | Low | Verify each metric in real sketchybar UI before finalizing; acceptance criteria includes visual confirmation |
| GPU shows 0% when actively rendering | Very Low | Expected behavior when no GPU-heavy app is running; verify with `gpu_stats` tool or activity monitor |
| Subprocess overhead increases due to merged process | Low | Consolidation reduces process count; monitor via Activity Monitor if needed |
| Git history confusion from deleted files | Low | Document deletion in git commit message; deleted files still recoverable from git log |
| Sketchybarrc syntax error breaks bar on load | Low | Validate syntax before deploying; test with `sketchybarrc --check` equivalent |

## Rollback Plan

**If consolidation breaks metrics**:
1. Revert to previous git commit: `git revert <commit-hash>`
2. Restore old plugin files: `git checkout HEAD~1 -- plugins/cpu.py plugins/gpu.py plugins/ram.py ...`
3. Reload sketchybar: `pkill -f sketchybar` && restart sketchybar app
4. Verify metrics reappear correctly

**If specific plugin fails**:
- Individual plugin files are recoverable from git history (`git show HEAD~1:plugins/cpu.py`)
- Can be restored on-demand if needed

**Prevention**: All acceptance criteria include real-time verification in sketchybar before marking complete.

## Dependencies

- Git history cleanup (old plugins must be deleted and committed)
- Sketchybar restart required after config change
- No external dependency on other projects; self-contained within sketchybar config

## Success Criteria

- [ ] All 3 new consolidated plugins present and executable (`system-stats.py`, `connectivity.py`, `battery.py`)
- [ ] CPU usage metric displays correctly in sketchybar (real-time updates)
- [ ] GPU utilization displays correctly (0% when idle is expected behavior)
- [ ] RAM usage displays correctly with percentage and used/total in MB
- [ ] WiFi status and signal strength display in connectivity.py output
- [ ] Battery percentage displays correctly
- [ ] Old plugin files removed from disk (`cpu.py`, `gpu.py`, `ram.py`, `wifi.py` deleted)
- [ ] Sketchybarrc bar items reference only consolidated plugins (no broken references)
- [ ] No console errors or warnings on `sketchybarrc` load
- [ ] Git history clean: deleted files committed, rollback plan documented
- [ ] `design.md` documents consolidated architecture and metric ownership boundaries
- [ ] Plugins tested in real sketchybar environment, metrics update correctly over 5+ minute observation

## Notes

- **Current State**: Consolidation already implemented in working directory; this proposal formalizes and archives the work
- **GPU 0% Behavior**: Verified as correct; GPU stats show 0% when no GPU-heavy processes are running
- **Git Cleanup**: Old plugins deleted from git but recoverable via `git log` if needed for reference

---

**Proposal Status**: Ready for Specifications phase (sdd-spec)
