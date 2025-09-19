#!/usr/bin/env nu

const timezones = [
  "US/Pacific" "America/Regina" "US/Eastern" "Europe/Berlin" "Asia/Tokyo" "Australia/Melbourne"
];

# buttons
# 1 - left click
# 2 - middle click
# 3 - right click
# 4 - scroll up
# 5 - scroll down

mut tz_index = $env | get -i tz_index | default 0 | into int;
mut is_current = $env | get -i is_current | default true | into bool;
let btn = $env | get -i button | default (-1) | into int;

# middle click -> switch from current timezone to other timezones
if $btn == 2 {
  $is_current = not $is_current;
}

mut date_str = "";
if $is_current {
  # example: za 2025-09-20 12:34:56 IST
  let fmt_str = '+%a %F %X <span color="#f1fa8c">%Z</span>';
  $date_str = ^date $fmt_str;
} else {
  # only switch the non-current timezone if it's visible
  # left click -> previous timezone
  # right click -> next timezone
  let offset = match $btn {
    1 => -1,
    3 => 1,
    _ => 0,
  };
  $tz_index = ($tz_index + $offset) mod ($timezones | length);
  let tz = $timezones | get $tz_index;

  # example: za 2025-09-20 12:34 IST (UTC+01)
  let fmt_str = '+%a %F %H<span color="#f1fa8c">:</span>%M<span color="#f1fa8c"> %Z</span> (UTC%:::z)'
  $date_str = TZ=$tz ^date $fmt_str;
}

{
  full_text: $"<span color=\"#f1fa8c\"> </span>($date_str)",
  tz_index: $tz_index
  is_current: $is_current
} | to json | print
