
ask() {
  command claude -p --model haiku --input-format text --output-format text "'$*'"
}
