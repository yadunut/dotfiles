let 
  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmQbdvFi1p8L5urBigTMuyD9yW0UbAPVKGzz2apANlc root@nixos";
  systems = [ system1 ];
in
{
  "tailscale.age".publicKeys = systems;
}

