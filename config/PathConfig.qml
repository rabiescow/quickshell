pragma Singleton

import Quickshell

Singleton {
    readonly property string root: Quickshell.configDir
    readonly property string script: root + "/scripts"

    readonly property string networkBandwidthScript: `${script}/network.sh`
    readonly property string keyboardLayoutScript: `${script}/keyboard.sh`
}
