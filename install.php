<?php
function plugin_version_securitycertificate()
{
  return array('name' => 'securitycertificate',
  'version' => '1.0',
  'author'=> 'Charlene AUGER, Rudy LAURENT',
  'license' => 'GPLv2',
  'verMinOcs' => '2.4');
}

function plugin_init_securitycertificate()
{
  $object = new plugins;
  $object->add_cd_entry("securitycertificate", "other");

  // Security Certificate table creation
  $object -> sql_query("CREATE TABLE IF NOT EXISTS `securitycertificate` (
                        `ID` INT(11) NOT NULL AUTO_INCREMENT,
                        `HARDWARE_ID` INT(11) NOT NULL,
                        `NAME` VARCHAR(255) DEFAULT NULL,
                        `AUTORITY` VARCHAR(255) DEFAULT NULL,
                        `DATESTART` VARCHAR(255) DEFAULT NULL,
                        `EXPIRATION` VARCHAR(255) DEFAULT NULL,
                        PRIMARY KEY (`ID`, `HARDWARE_ID`)
                        ) ENGINE=INNODB;");
}

function plugin_delete_securitycertificate()
{
  $object = new plugins;
  $object -> del_cd_entry("securitycertificate");

  $object -> sql_query("DROP TABLE `securitycertificate`;");
}
