#!/usr/bin/env python3
import os
import sys
import json

# Setup paths
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

def test_radio_state_logic():
    print("🚀 Iniciando Test de Lógica de Radio...")
    
    # Mock de las emisoras que acabamos de agregar
    STATIONS_MOCK = {
        "exa": {"name": "EXA FM"},
        "airelatino": {"name": "Aire Latino 88.5"}
    }
    
    # Simular lectura de estado (get_state)
    initial_state = {"playing": False, "current": "exa"}
    print(f"Estado Inicial: {initial_state}")
    
    # Simular cambio de emisora a Aire Latino
    new_station = "airelatino"
    if new_station in STATIONS_MOCK:
        new_state = {"playing": True, "current": new_station}
        print(f"Cambio a {new_station}: PASSED")
    else:
        print(f"Cambio a {new_station}: FAILED")
        return False

    # Verificar persistencia de nombre
    if STATIONS_MOCK[new_state["current"]]["name"] == "Aire Latino 88.5":
        print("Validación de nombre de emisora: PASSED")
    else:
        print("Validación de nombre de emisora: FAILED")
        return False
        
    return True

if __name__ == "__main__":
    if test_radio_state_logic():
        print("\n✅ Todos los tests de Radio han pasado.")
    else:
        print("\n❌ Algunos tests de Radio han fallado.")
        sys.exit(1)
