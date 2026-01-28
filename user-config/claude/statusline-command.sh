#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract basic info
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
parent_name=$(basename "$(dirname "$current_dir")")
current_name=$(basename "$current_dir")
dir_name="${parent_name}/${current_name}"

# Git information
git_info=""
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$current_dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || \
             git -C "$current_dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

    # Check if dirty
    if ! git -C "$current_dir" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$current_dir" --no-optional-locks diff --cached --quiet 2>/dev/null; then
        dirty="*"
    else
        dirty=""
    fi

    git_info=" on ${branch}${dirty}"
fi

# Subscription information
sub_info=""
daily_cost=$(echo "$input" | jq -r '.subscription.daily_cost_usd_cents // empty')
if [ -n "$daily_cost" ]; then
    dollars=$(echo "scale=2; $daily_cost / 100" | bc)
    sub_info=" | \$${dollars} today"
else
    plan_name=$(echo "$input" | jq -r '.subscription.plan_name // empty')
    if [ -n "$plan_name" ]; then
        sub_info=" | ${plan_name}"
    fi
fi

# Context window info
context_info=""
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
if [ -n "$remaining" ]; then
    context_info=" | ctx: ${remaining}%"
fi

# Output the status line
printf "%s%s%s%s" "$dir_name" "$git_info" "$sub_info" "$context_info"
