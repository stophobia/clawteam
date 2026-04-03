#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${1:-$PWD}"

mkdir -p "${TARGET_DIR}/.agents/skills" "${TARGET_DIR}/.claude/skills"

link_path() {
  local source_path="$1"
  local target_path="$2"

  if [ -e "${target_path}" ] && [ ! -L "${target_path}" ]; then
    echo "Error: ${target_path} exists and is not a symlink." >&2
    exit 1
  fi

  rm -f "${target_path}"
  ln -s "${source_path}" "${target_path}"
}

link_path "${REPO_ROOT}/.agents/skills/clawteam-dev" "${TARGET_DIR}/.agents/skills/clawteam-dev"
link_path "${REPO_ROOT}/skills/clawteam" "${TARGET_DIR}/.claude/skills/clawteam"
link_path "${REPO_ROOT}/.agents/skills/clawteam-dev" "${TARGET_DIR}/.claude/skills/clawteam-dev"

echo "Linked local ClawTeam skills into ${TARGET_DIR}"
echo "  .agents/skills/clawteam-dev -> ${REPO_ROOT}/.agents/skills/clawteam-dev"
echo "  .claude/skills/clawteam -> ${REPO_ROOT}/skills/clawteam"
echo "  .claude/skills/clawteam-dev -> ${REPO_ROOT}/.agents/skills/clawteam-dev"
