#!/usr/bin/env -S uv run --script
import platform
import subprocess

"""
Raise a desktop notification with sound when Claude Code is finished and
waiting for user input.
"""


def main() -> None:
    # Only works on macOS
    assert platform.system() == "Darwin"

    subprocess.run(
        [
            "osascript",
            "-e",
            'set variableWithSoundName to "Glass"',
            "-e",
            'display notification "Claude Code finished" with title "Claude" sound name variableWithSoundName',
            # TODO: 'display notification "json.load(sys.stdin)['XYZ']" with title "Claude Code finished" subtitle "???" sound name variableWithSoundName
        ]
    )
    # subprocess.run(
    #     [
    #         "afplay",
    #         "/System/Library/Sounds/Glass.aiff",
    #     ]
    # )


if __name__ == "__main__":
    main()
