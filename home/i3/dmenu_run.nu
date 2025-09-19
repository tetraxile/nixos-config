#!/usr/bin/env nu
let meow = dmenu_path | dmenu | split row ' ';
run-external ...$meow;
