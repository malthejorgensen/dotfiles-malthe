#!/usr/bin/env -S uv run --script
import platform
import subprocess
import json
import re
import sys
from typing import assert_never

"""
Raise a desktop notification with sound when Codex is finished and
waiting for user input.
"""


def main() -> int:

    # Only works on macOS
    assert platform.system() == "Darwin"

    if len(sys.argv) != 2:
        print("Usage: notify.py <NOTIFICATION_JSON>")
        return 1

    try:
        notification = json.loads(sys.argv[1])
    except json.JSONDecodeError:
        return 1

    with open("/Users/malthejorgensen/.codex/notification-log-malthe.log", "a") as f:
        notification_json = json.dumps(notification, indent=4)
        f.write("\n\n" + notification_json)

    match notification_type := notification.get("type"):
        case "agent-turn-complete":
            assistant_message = notification.get("last-assistant-message")
            # if assistant_message:
            #     title = f"Codex: {assistant_message}"
            # else:
            #     title = "Codex: Waiting for input"
            input_messages = notification.get("input_messages", [])
            message = " ".join(input_messages)
            # title += message
        case _:
            print(f"not sending a push notification for: {notification_type}")
            return 0

    notification_title = "Codex: Waiting for input"
    notification_content = assistant_message or "No output from Codex"
    # Remove offending characters
    notification_content = re.sub(r"[\"'`]", "", notification_content)
    subprocess.run(
        [
            "osascript",
            "-e",
            'set variableWithSoundName to "Glass"',
            "-e",
            # {title} {message}
            f'display notification "{notification_content}" with title "{notification_title}" sound name variableWithSoundName',
        ]
    )

    return 0


if __name__ == "__main__":
    sys.exit(main())
