# Manage-Linux-User-From-GUI

```
Outil en développement permettant la gestion des utilisateurs sous linux via GUI. Cet Outil sera orienté Client.
```
## Documentation
https://docs.google.com/document/d/1ZGPldG3y0xxyNgo2dAurYcL2Fo1Yz56cMY-sqqVm2Z0/edit?usp=sharing

### PhP + Bash + ssh || API
- PhP + shell_exec()
- from html/css + bootstrap || materialize
- if API, API = PhP || Java || NodeJs

### SSH connection through PhP
use : shell_exec_ssh_connection()

sample : 
```
<?php
include('Net/SSH2.php');

$ssh = new Net_SSH2('www.domain.tld');
if (!$ssh->login('username', 'password')) {
    exit('Login Failed');
}

echo $ssh->exec('pwd');
echo $ssh->exec('ls -la');
?>
```

## Hébergement

- où l'héberger ? new ovh vps (iptables, fail2ban, randsomeware_scan) ?
