#!/usr/bin/env python3
import os
import sys
from unittest.mock import MagicMock, patch

# Setup paths
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

# Mock utils
import utils
utils.COLORS = {"ISLAND_BG": "0x00", "ISLAND_BORDER": "0x00", "BLUE": "0x00", "DIM": "0x00", "RED": "0x00", "GREEN": "0x00", "WHITE": "0x00", "ORANGE": "0x00", "YELLOW": "0x00"}
utils.sbar_set = MagicMock()

import docker
import k8s
import cve_intel
import ucm

def test_docker_parsing():
    print("\n[1] Testing Docker Logic Parsing...")
    mock_ps = "ID1|nginx|Up 2 hours\nID2|db|Exited (0) 5 minutes ago"
    with patch('subprocess.run') as mock_run:
        mock_run.return_value = MagicMock(stdout=mock_ps, returncode=0)
        containers = docker.get_docker_containers()
        assert len(containers) == 2
        assert containers[0]["name"] == "nginx"
        print("  ✅ Docker Logic: OK")

def test_k8s_parsing():
    print("\n[2] Testing K8s Logic Parsing...")
    mock_nodes = "node1 Ready\nnode2 NotReady"
    with patch('subprocess.run') as mock_run:
        mock_run.return_value = MagicMock(stdout=mock_nodes, returncode=0)
        nodes = k8s.get_k8s_nodes()
        assert len(nodes) == 2
        assert nodes[0]["status"] == "Ready"
        print("  ✅ K8s Logic: OK")

def test_ucm_countdown():
    print("\n[3] Testing UCM Countdown Logic...")
    from datetime import datetime, timedelta
    with patch('ucm.MILESTONES', [{"name": "Test", "date": (datetime.now() + timedelta(days=5)).strftime("%Y-%m-%d")}]):
        upcoming = ucm.get_countdown()
        assert len(upcoming) == 1
        assert upcoming[0]["days"] == 4 or upcoming[0]["days"] == 5 # Depending on current time
        print("  ✅ UCM Logic: OK")

if __name__ == "__main__":
    try:
        test_docker_parsing()
        test_k8s_parsing()
        test_ucm_countdown()
        print("\n🚀 TESTS DE NUEVOS PLUGINS PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR: {e}")
        sys.exit(1)
