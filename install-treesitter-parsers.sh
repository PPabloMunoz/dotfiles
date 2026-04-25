#!/usr/bin/env bash
set -e

PARSER_DIR="$HOME/.local/share/nvim/site/parser"
QUERIES_DIR="$HOME/.config/nvim/queries"
BASE_URL="https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter/master/queries"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
  local branch="${4:-}"      # optional branch

  if [ -f "$PARSER_DIR/$name.so" ]; then
    echo -e "${YELLOW}➜ $name parser is already installed. Skipping...${NC}"
    return 0
  fi

  echo -e "${BLUE}⚙ Installing $name parser...${NC}"

  local TMP_DIR=$(mktemp -d)
  trap "rm -rf $TMP_DIR" EXIT

  if [ -n "$branch" ]; then
    git clone --depth=1 -b "$branch" "$repo" "$TMP_DIR/$name"
  else
    git clone --depth=1 "$repo" "$TMP_DIR/$name"
  fi

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

  echo -e "${GREEN}✓ $name parser installed.${NC}"
}

install_queries() {
  local lang="$1"
  shift
  local files=("$@")

  mkdir -p "$QUERIES_DIR/$lang"

  for file in "${files[@]}"; do
    local url="$BASE_URL/$lang/$file"
    local dest="$QUERIES_DIR/$lang/$file"
    echo -e "${BLUE}  ⬇ Fetching $lang/$file...${NC}"
    curl -fsSL "$url" -o "$dest" || echo -e "${YELLOW}  ⚠ Warning: could not fetch $url${NC}"
  done
}

install_ecma_queries() {
  echo -e "${BLUE}⚙ Fetching ECMA queries (base for JS/TS)...${NC}"
  mkdir -p "$QUERIES_DIR/ecma"
  for file in "highlights.scm" "indents.scm" "locals.scm"; do
    curl -fsSL "$BASE_URL/ecma/$file" -o "$QUERIES_DIR/ecma/$file" || echo -e "${YELLOW}  ⚠ Warning: could not fetch ecma/$file${NC}"
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

# --- SQL ---
compile_parser "sql" "https://github.com/DerekStride/tree-sitter-sql" "" "gh-pages"
install_queries "sql" "highlights.scm" "indents.scm"

echo -e "\n${GREEN}✨ All parsers processed successfully.${NC}"
