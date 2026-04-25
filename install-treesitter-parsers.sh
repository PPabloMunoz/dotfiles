#!/usr/bin/env bash
set -e

PARSER_DIR="$HOME/.local/share/nvim/site/parser"
QUERIES_DIR="$HOME/.config/nvim/queries"
BASE_URL="https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter/master/queries"

mkdir -p "$PARSER_DIR"

if ! command -v gcc &>/dev/null; then
  echo "gcc not found, skipping tree-sitter parser installs"
  exit 0
fi

OS="$(uname -s)"

compile_parser() {
  local name="$1"
  local repo="$2"
  local src_subdir="${3:-}"  # optional subdirectory inside the repo

  echo "Installing $name parser..."

  local TMP_DIR=$(mktemp -d)
  trap "rm -rf $TMP_DIR" EXIT

  git clone --depth=1 "$repo" "$TMP_DIR/$name"

  local SRC_DIR="$TMP_DIR/$name"
  [ -n "$src_subdir" ] && SRC_DIR="$SRC_DIR/$src_subdir"
  cd "$SRC_DIR"

  local SOURCES="src/parser.c"
  [ -f src/scanner.c ] && SOURCES="$SOURCES src/scanner.c"
  [ -f src/scanner.cc ] && SOURCES="$SOURCES src/scanner.cc"

  if [ "$OS" = "Darwin" ]; then
    gcc -o "$PARSER_DIR/$name.so" -shared -fPIC -Os \
      -undefined dynamic_lookup -I src $SOURCES -lstdc++
  else
    gcc -o "$PARSER_DIR/$name.so" -shared -fPIC -Os -I src $SOURCES -lstdc++
  fi

  echo "$name parser installed."
}

install_queries() {
  local lang="$1"
  shift
  local files=("$@")

  mkdir -p "$QUERIES_DIR/$lang"

  for file in "${files[@]}"; do
    local url="$BASE_URL/$lang/$file"
    local dest="$QUERIES_DIR/$lang/$file"
    echo "Fetching $lang/$file..."
    curl -fsSL "$url" -o "$dest" || echo "Warning: could not fetch $url"
  done
}

install_ecma_queries() {
  echo "Fetching ECMA queries (base for JS/TS)..."
  mkdir -p "$QUERIES_DIR/ecma"
  for file in "highlights.scm" "indents.scm" "locals.scm"; do
    curl -fsSL "$BASE_URL/ecma/$file" -o "$QUERIES_DIR/ecma/$file" || echo "Warning: could not fetch ecma/$file"
  done
}

# --- ECMA (Base) ---
install_ecma_queries

# --- Go ---
compile_parser "go" "https://github.com/tree-sitter/tree-sitter-go"
install_queries "go" "highlights.scm" "indents.scm"

# --- TypeScript ---
compile_parser "typescript" "https://github.com/tree-sitter/tree-sitter-typescript" "typescript"
install_queries "typescript" "highlights.scm" "indents.scm" "locals.scm"

# --- TSX ---
compile_parser "tsx" "https://github.com/tree-sitter/tree-sitter-typescript" "tsx"
install_queries "tsx" "highlights.scm" "indents.scm" "locals.scm"

# --- Bash ---
compile_parser "bash" "https://github.com/tree-sitter/tree-sitter-bash"
install_queries "bash" "highlights.scm"

echo "All parsers installed successfully."
