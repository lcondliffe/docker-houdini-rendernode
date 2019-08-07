$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("r:", "\\university.ds.derby.ac.uk\private$\DeadlineRepository10", $false, "UNIVERSITY\SRV-DeadlineSlave", "PASSWORD")
