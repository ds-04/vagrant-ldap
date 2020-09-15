# OpenLDAP Vagrant box

Builds a simple OpenLDAP Vagrant Server with a couple of users and groups. See `conf/ldap` for full details on the users and groups that are created. Also creates a `vaultadmin` user and group, since the intention of this LDAP server is for it to be used as part of Vault demos.

Note: This configuration is purely for demo purposes and in no way attempts to define any best-practice in creating an OpenLDAP server!

## Usage

1. clone the repo
2. vagrant up
3. Use the binddn `cn=admin,dc=foo,dc=com` and password `password` when configuring clients.

### Testing
```
ldapsearch -x -LLL -H ldap:/// -b uid=a_user,ou=people,dc=foo,dc=com dn memberof
```

## Thanks/Kudos
Based on https://github.com/iainthegray/vagrant-ldap, but with full automation on setup of the OpenLDAP server and minus the Marvel characters.