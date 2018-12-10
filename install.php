<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_securitycertificate()
{
  $commonObject = new ExtensionCommon;

  // Security Certificate table creation
  $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `securitycertificate` (
                        `ID` INT(11) NOT NULL AUTO_INCREMENT,
                        `HARDWARE_ID` INT(11) NOT NULL,
                        `NAME` VARCHAR(255) DEFAULT NULL,
                        `AUTORITY` VARCHAR(255) DEFAULT NULL,
                        `DATESTART` VARCHAR(255) DEFAULT NULL,
                        `EXPIRATION` VARCHAR(255) DEFAULT NULL,
                        PRIMARY KEY (`ID`, `HARDWARE_ID`)
                        ) ENGINE=INNODB;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_securitycertificate()
{
  $commonObject = new ExtensionCommon;
  $commonObject -> sqlQuery("DROP TABLE `securitycertificate`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_securitycertificate()
{

}
