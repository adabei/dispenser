$programs = @("devenv",
              "vlc")
$energyModes = @{"balanced" = "381b4222-f694-41f0-9685-ff5bb260df2e";
                 "high" = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"}
$inHighPerformance = 0
$found = 0
while (1){
  Get-Process | ForEach-Object {
    if ($programs -contains $_.name) {
      $found = 1
    }
  }
  if($found) {
    if($inHighPerformance -eq 0) {
      powercfg -s $energyModes["high"]
      $inHighPerformance = 1
    }
  } else {
    if($inHighPerformance -eq 1) {
      powercfg -s $energyModes["balanced"]
      $inHighPerformance = 0
    }
  }
  if($found){
    Start-Sleep -s ((120, 180, 300, 420) | Get-Random)
  } else {
    Start-Sleep -s ((10, 30, 30, 45, 60) | Get-Random)
  }
  $found = 0
}
