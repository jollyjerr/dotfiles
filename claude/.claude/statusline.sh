#!/usr/bin/env bash

jq -r '
  def pct: if . == null then empty else (. | floor | tostring) + "%" end;
  [
    .model.display_name,
    (if (.effort | type) == "string" then .effort
     elif (.effort.level | type) == "string" then .effort.level
     else empty end),
    ("ctx " + (.context_window.used_percentage | pct)),
    (if .rate_limits.five_hour.used_percentage != null then "5h " + (.rate_limits.five_hour.used_percentage | pct) else empty end),
    (if .rate_limits.seven_day.used_percentage != null then "7d " + (.rate_limits.seven_day.used_percentage | pct) else empty end),
    (if .cost.total_cost_usd != null then "$" + (.cost.total_cost_usd * 100 | round / 100 | tostring) else empty end)
  ]
  | map(select(. != null and . != "" and . != "ctx "))
  | join(" · ")
'
