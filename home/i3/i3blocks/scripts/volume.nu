#!/usr/bin/env nu

const icons = [ "󰝟" "󰕿" "󰖀" "󰕾" ];

let output = wpctl get-volume @DEFAULT_AUDIO_SINK@;
let parsed = $output | parse --regex '(Volume:\s+)(?P<vol>[0-9.]+)(?P<muted>.+)?' | first;
let volume = $parsed | get vol | into float | $in * 100;
let is_muted = $parsed | get muted | str length | into bool;

mut icon = "";
if $is_muted or $volume == 0 {
    $icon = $icons.0;
} else if $volume <= 25 {
    $icon = $icons.1;
} else if $volume <= 65 {
    $icon = $icons.2;
} else {
    $icon = $icons.3;
}

{
    full_text: $"<span size=\"large\">($icon)</span> ($volume)%",
    urgent: $is_muted
} | to json | print
