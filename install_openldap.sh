#!/bin/bash


# Silently install LDAP
sudo apt-get update -y && \
echo 'slapd slapd/root_password password password' | debconf-set-selections && \
echo 'slapd slapd/root_password_again password password' | debconf-set-selections && \
echo 'slapd slapd/internal/adminpw password password' | debconf-set-selections && \
echo 'slapd slapd/internal/generated_adminpw password password' | debconf-set-selections && \
echo 'slapd slapd/password1 password password' | debconf-set-selections && \
echo 'slapd slapd/password2 password password' | debconf-set-selections && \
echo 'slapd slapd/domain string foo.com' | debconf-set-selections && \
echo 'slapd slapd/organization string foo' | debconf-set-selections && \
DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils

# Configure LDAP 
sudo ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w password -f /vagrant/conf/ldap/ldap_base.ldif
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /vagrant/conf/ldap/load_memberof.ldif
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /vagrant/conf/ldap/load_memberof_overlay.ldif
sudo ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w password -f /vagrant/conf/ldap/ldap_users.ldif
sudo ldapadd -x -H ldap://127.0.0.1:389/ -D "cn=admin,dc=foo,dc=com" -w password -f /vagrant/conf/ldap/ldap_groups.ldif