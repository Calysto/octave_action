lint *args:
    prek run --all-files {{args}}

lint-all *args:
    prek run --all-files --hook-stage manual {{args}}
