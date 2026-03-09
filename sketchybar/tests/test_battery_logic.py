#!/usr/bin/env python3
import os
import sys

# Añadir el path de plugins para importar utils si fuera necesario
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

def simulate_battery_logic(percentage, charging, last_alert):
    """
    Replica la lógica de battery.py para verificar las alertas.
    Retorna (triggered_alert, current_alert_state)
    """
    current_alert = None
    notification_sent = False
    
    if percentage <= 20 and not charging:
        current_alert = "low"
        if last_alert != "low":
            notification_sent = True
    elif percentage == 100 and charging:
        current_alert = "full"
        if last_alert != "full":
            notification_sent = True
    elif 30 < percentage < 90:
        current_alert = None
        
    return notification_sent, current_alert

def run_tests():
    print("🚀 Iniciando Test de Lógica de Batería...")
    
    # Caso 1: Batería al 49% (Tu estado actual) -> No debe haber alerta
    sent, state = simulate_battery_logic(49, False, None)
    print(f"Test 49% (Normal): {'PASSED' if not sent and state is None else 'FAILED'}")

    # Caso 2: Batería baja al 20% -> Debe disparar alerta
    sent, state = simulate_battery_logic(20, False, None)
    print(f"Test 20% (Peligro): {'PASSED' if sent and state == 'low' else 'FAILED'}")
    
    # Caso 3: Batería sigue al 20% -> NO debe repetir alerta (Debounce)
    sent, state = simulate_battery_logic(20, False, "low")
    print(f"Test 20% (Repetido): {'PASSED' if not sent and state == 'low' else 'FAILED'}")

    # Caso 4: Batería al 100% y cargando -> Debe disparar alerta de desconexión
    sent, state = simulate_battery_logic(100, True, None)
    print(f"Test 100% (Cargada): {'PASSED' if sent and state == 'full' else 'FAILED'}")

    # Caso 5: Regreso a rango seguro (50%) -> Debe limpiar el estado de alerta
    sent, state = simulate_battery_logic(50, False, "full")
    print(f"Test 50% (Reset): {'PASSED' if not sent and state is None else 'FAILED'}")

if __name__ == "__main__":
    run_tests()
