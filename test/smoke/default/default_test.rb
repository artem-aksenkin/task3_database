# # encoding: utf-8

# Inspec test for recipe task3_database::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


  # This is an example test, replace with your own test.
describe user('root') do
  it { should exist }
end

# This is an example test, replace it with your own test.
describe port(3306) do
  it { should be_listening }
end

describe service('mysql-default') do
  it { should be_enabled }
  it { should be_running }
end

describe bash("mysql -S /var/run/mysql-default/mysqld.sock -uroot -ppassword -e 'show databases'") do
  its('stdout') { should include 'task3' }
end

# describe mysql_session('uroot', 'ppassword') do
#   its('port') { should eq '3306' }
#   its('socket') { should eq '/var/run/mysql-default/mysqld.sock' }
#   its('default_storage_engine') { should eq 'InnoDB' }
#   its('character_set_server') { should eq 'utf8' }
#   its('collation_server') { should eq 'utf8_general_ci' }
# end