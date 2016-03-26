execute 'brew services start mysql' do
  only_if 'uname | grep Darwin && mysql.server status | grep "is not running"'
end

execute 'initialize mysql' do
  command <<-'EOF'
    TEMP_PASSWORD='Passw0rd!'
    mysql -uroot -p"$(grep 'password is generated' /var/log/mysqld.log | cut -d' ' -f 11 | sed -e 's/"/\\"/g')" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${TEMP_PASSWORD}';" --connect-expired-password
    mysql -uroot -p${TEMP_PASSWORD} -e "UNINSTALL PLUGIN validate_password;"
    mysql -uroot -p${TEMP_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '' PASSWORD EXPIRE NEVER;"
  EOF
  user     'root'
  only_if  "mysql -uroot -e 'exit'; [ $? == 1 ] && grep 'password is generated' /var/log/mysqld.log"
end
