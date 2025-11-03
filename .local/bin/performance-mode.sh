#!/usr/bin/env bash
set -e

echo "🚀 Switching to Performance Mode..."

sudo supergfxctl -m Hybrid || true
asusctl profile -P Performance || true
echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo >/dev/null
sudo cpupower frequency-set -u 0 || true

echo "✅ Performance Mode activated."
