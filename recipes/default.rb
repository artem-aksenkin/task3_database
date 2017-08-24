#
# Cookbook:: task3_database
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package "net-tools"

execute 'mysql-community-repo' do
command 'wget https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm'
command 'rpm -ivh mysql57-community-release-el7-11.noarch.rpm'
command 'yum-config-manager --enable mysql57-community'
command 'yum-config-manager --disable  mysql56-community'
command 'rpm -qf /bin/yum-config-manager'
command 'yum update -y mysql-community-server -y'
action :run
end

# service 'mysqld' do
#   action [:enable, :start]
# end

mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  port '3306'
  initial_root_password 'password'
  action [:create, :start]
end


bash 'create database' do
  code <<-EOH
    mysql -S /var/run/mysql-default/mysqld.sock -uroot -ppassword -e "create database task3 character set utf8 collate utf8_bin;"  
    EOH
  action :run
  not_if "mysql -S /var/run/mysql-default/mysqld.sock -uroot -ppassword -e 'show databases' | grep task3"
end

