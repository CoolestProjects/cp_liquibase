Coolest Projects Liquibase Chef Cookbook
====================

This cookbook sets up and runs liqubase for a given project's sql binary, this recipe runs by convention and expects 
* sql binary to be a zip format
* changelog file to be called changelog.xml
* changelog.xml must be inside the root folder of the zip binary

Vagrant Note
------------
The sample sql binary can be found inside the test folder, but you can test this recipe against your sql binary in vagrant by changing 

Requirements
------------
* Chef 11 or higher

Platforms
------------
Tested on

* CentOs 6

Attributes
----------

Sets the default java settings for the servers

	### java.rb
    default['java']['oracle_rpm']['type'] = "jdk"
	default['java']['jdk_version'] = "8"
	default['java']['install_flavor'] = "oracle"
	default['java']['jdk']['8']['x86_64']['bin_cmds'] = ["java", "javac"]

License & Authors
-----------------
- Author:: Noel King (<coolestprojects@coderdojo.com>)



# Coolest Projects Liquibase Chef Cookbook

Run liquibase on remote machines using the following run option java -jar liquibase.jar

## Attributes

````
default['cp_liquibase']['group'] = "liquibase"
default['cp_liquibase']['user'] = "liquibase"
default['cp_liquibase']['install_dir'] = "/opt/liquibase"
default['cp_liquibase']['dist_dir'] = "/opt/liquibase/dist"



default['cp_liquibase']['url']="http://artifactory.cpware.ie/artifactory/simple/ext-binary/liquibase/liquibase/3.2.2/liquibase-3.2.2.zip"
default['cp_liquibase']['binary_file_name']="liquibase-3.2.2.zip"
default['cp_liquibase']['driver_jar_url'] = "http://artifactory.cpware.ie/artifactory/simple/ext-binary/mysql-connector-java/mysql-connector-java/5.1.25/mysql-connector-java-5.1.25.jar"
default['cp_liquibase']['driver_file_name'] = "mysql-connector-java-5.1.25.jar"
default['cp_liquibase']['db_driver'] = "com.mysql.jdbc.Driver"
default['cp_liquibase']['db_user'] = "root"
default['cp_liquibase']['db_password'] = "cpwaremysql"
default['cp_liquibase']['db_url'] = "jdbc:mysql://localhost:3306/liquibase_test"
default['cp_liquibase']['command'] = "update"


default['cp_liquibase']["sql_binary_url"]="http://artifactory.cpware.ie/artifactory/simple/libs-release-local/com/cpware/liquibase/sample-sql/liquibase-sample-sql.zip"
````
