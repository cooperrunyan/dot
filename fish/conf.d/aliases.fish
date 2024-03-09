if status is-interactive
  abbr g "git"
  abbr v "nvim"
  abbr rg "ranger"
  abbr = "math"
  alias ls "ls -phFHAtG --color"
  alias mkdir "mkdir -p"
  abbr dev "code ~/dev/"

  if command -sq bat
      alias cat "bat"
  end
end
