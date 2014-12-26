default['cp_liquibase']['group'] = "liquibase"
default['cp_liquibase']['user'] = "liquibase"
default['cp_liquibase']['install_dir'] = "/opt/liquibase"
default['cp_liquibase']['dist_dir'] = "/opt/liquibase/dist"
default['cp_liquibase']['zip_foldername'] = ""

default['cp_liquibase']['url']="http://downloads.sourceforge.net/project/liquibase/Liquibase%20Core/liquibase-3.2.2-bin.zip?r=&ts=1413845720&use_mirror=kent"
default['cp_liquibase']['binary_file_name']="liquibase-3.2.2.zip"
default['cp_liquibase']['driver_jar_url'] = "http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.25/mysql-connector-java-5.1.25.jar"
default['cp_liquibase']['driver_file_name'] = "mysql-connector-java-5.1.25.jar"
default['cp_liquibase']['db_driver'] = node["database"]["driver_class"]
default['cp_liquibase']['db_user'] = node["database"]["username"]
default['cp_liquibase']['db_password'] = node["database"]["password"]
default['cp_liquibase']['db_url'] = node["database"]["jdbc_url"]
default['cp_liquibase']['command'] = "update"

default['cp_liquibase']["sql_binary_url"]=""
default['cp_liquibase']['dist_local_file_path'] = "/dist/"
default['cp_liquibase']['use_local_dist'] = "false"

