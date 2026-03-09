# Delta Spec: Battery Health Alerts (v3.2.0)

**Status**: PROPOSED
**Target**: `plugins/battery.py`

## Requirements
1. **Low Power Alert**: 
   - Trigger: Battery falls to **20%** AND is NOT charging.
   - Action: OS Notification "⚠️ ¡Peligro! Busca tu cargador y una fuente de electricidad ⚡".
2. **Critical Power Alert**:
   - Trigger: Battery falls to **10%** AND is NOT charging.
   - Action: OS Notification "🚨 CRÍTICO: Batería al 10%. ¡Último aviso! Conecta el cargador inmediatamente 🔌⚡".
3. **Full Charge Alert**:
   - Trigger: Battery reaches **100%** AND IS charging/attached.
   - Action: OS Notification "✅ Carga Completa: Desconecta el cargador para proteger la vida útil de tu batería 🔋".
3. **Non-Blocking**: Alerts MUST use `osascript` notifications (native macOS toast) to avoid UI locking.
4. **Debouncing**: Ensure the alert only triggers ONCE per state change to avoid spamming every 60 seconds.

## Proposed Changes
- Modify `battery.py` to include state tracking (storing last alert status in a temp file or memory).
- Implement logic for triggering notifications based on the 20% and 100% thresholds.
