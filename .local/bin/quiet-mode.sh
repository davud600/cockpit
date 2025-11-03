#!/usr/bin/env bash

set -e

echo "🔇 Switching to Quiet Mode..."

if command -v supergfxctl &>/dev/null; then
  echo "→ Setting GPU mode: Integrated"
  sudo supergfxctl -m Integrated || echo "⚠️ Failed to switch GPU mode"
fi

if command -v asusctl &>/dev/null; then
  echo "→ Setting ASUS profile: Quiet"
  asusctl profile -P Quiet || echo "⚠️ Failed to set quiet profile"
  asusctl led-mode off || echo "⚠️ Could not disable LED"
fi

if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
  echo "→ Disabling CPU Turbo Boost"
  echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo >/dev/null
fi

if command -v cpupower &>/dev/null; then
  echo "→ Setting CPU max freq to 2.8GHz"
  sudo cpupower frequency-set -u 2.8GHz
fi

if systemctl list-unit-files | grep -q tlp.service; then
  echo "→ Restarting TLP for power savings"
  sudo systemctl restart tlp
elif command -v auto-cpufreq &>/dev/null; then
  echo "→ Restarting auto-cpufreq"
  sudo systemctl restart auto-cpufreq
fi

echo "✅ Quiet Mode activated."
