
function sudo {
  ARGS="$@"
  su root -c "$ARGS"
}

