alias llm="claude -p --model haiku --input-format text --output-format text"

ask() {
  llm -p --model haiku --input-format text --output-format text "'$*'"
}
