#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  cat <<EOF
Uso: ./upload-media.sh <ruta-al-archivo> [mensaje-de-commit]

Ejemplo:
  ./upload-media.sh ~/Descargas/video.mp4 "Agregar video promocional"
EOF
  exit 1
fi

SOURCE_FILE="$1"
shift
COMMIT_MESSAGE="${*:-Add media file $(basename "$SOURCE_FILE")}"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git no está instalado." >&2
  exit 1
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Error: no es un repositorio git. Ejecuta el script desde la raíz del proyecto." >&2
  exit 1
fi

if [ ! -f "$SOURCE_FILE" ]; then
  echo "Error: archivo no encontrado: $SOURCE_FILE" >&2
  exit 1
fi

UPLOADS_DIR="$REPO_DIR/uploads"
mkdir -p "$UPLOADS_DIR"
DEST_FILE="$UPLOADS_DIR/$(basename "$SOURCE_FILE")"

if [ -e "$DEST_FILE" ] && ! cmp -s "$SOURCE_FILE" "$DEST_FILE"; then
  echo "Advertencia: ya existe un archivo con el mismo nombre en uploads:"
  echo "  $DEST_FILE"
  printf '¿Deseas sobrescribirlo? [y/N]: '
  read -r answer
  case "$answer" in
    [Yy]*) ;;
    *) echo "Operación cancelada."; exit 1;;
  esac
fi

cp -f "$SOURCE_FILE" "$DEST_FILE"

git add "$DEST_FILE"

git commit -m "$COMMIT_MESSAGE"

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

echo "Empujando $DEST_FILE a GitHub (rama: $CURRENT_BRANCH)..."
git push origin "$CURRENT_BRANCH"

echo "Archivo subido y empujado correctamente: $DEST_FILE"
