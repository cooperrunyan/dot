function mvrm
  mv $argv[1]/{*,.*} . && rmdir $argv[1]
end
