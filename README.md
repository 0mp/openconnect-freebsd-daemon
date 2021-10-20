# OpenConnect FreeBSD Daemon

A service daemon for the FreeBSD rc(8) framework. It lets the user configure
OpenConnect VPN in rc.conf(5) and use the standard FreeBSD tools to control the
daemon.

Features:
- Support for starting multiple OpenConnect services.
- Support for running arbitrary commands for OTP-based authentication.

See the service files for usage details.

## Installation

```console
% make
% su
# make install
```

## Examples

Configure and connect to a VPN with OpenConnect:

```console
# sysrc openconnect_myvpn_enable="YES"
# sysrc openconnect_myvpn_username="charlie.root"
# sysrc openconnect_myvpn_server="vpn.example.org"
# service openconnect setpassword myvpn
Password (openconnect_myvpn):
# service openconnect start myvpn
```

Enable "myvpn" OpenConnect service to run on boot:

```console
# sysrc openconnect_services+="myvpn"
```

Enable verbose output (e.g., for debugging):

```console
# sysrc openconnect_myvpn_args+="--verbose"
```

Set the password manually:

```console
# mkdir -p /usr/local/etc/openconnect/passwords
# (umask 077 && echo "password" > /usr/local/etc/openconnect/passwords/myvpn)
```

## License

The 2-Clause BSD license.
