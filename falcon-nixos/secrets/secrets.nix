let 
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHMBVrt8ORitBVmkDSf78zli0M2+ggQtdnPEywqaaKA root@nixos";
  systems = [ system1 ];
in
{
  "tailscale.age".publicKeys = systems;
}

