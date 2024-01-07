POSH_THEMES_PATH=$(brew --prefix oh-my-posh)/themes
eval "$(oh-my-posh completion bash)"
eval "$(oh-my-posh init bash --config "$POSH_THEMES_PATH"/atomic.omp.json | sed 's|\[\[ -v MC_SID \]\]|[[ -n "$MC_SID" ]]|')"
