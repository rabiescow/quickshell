pragma Singleton

import Quickshell

Singleton {
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd dd:MM:yyyy hh:mm t");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
