#!/usr/bin/sh
sar -n DEV 1 | awk '
    /IFACE/ {
      for (i=1; i<=NF; i++) {
        if ($i == "rxkB/s") rx_col=i;
        if ($i == "txkB/s") tx_col=i;
      }
    }
    /enp17s0/ && !/Average/ {
      print $rx_col, $tx_col
      fflush()
    }
'
