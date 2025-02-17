-- MySQL Script generated by MySQL Workbench
-- Sun Jun 20 18:08:08 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Bank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Bank` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Bank` (
  `city` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costumer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Costumer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Costumer` (
  `ID` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NOT NULL,
  `ContactName` VARCHAR(45) NOT NULL,
  `ContactTel` VARCHAR(45) NOT NULL,
  `ContactEmail` VARCHAR(45) NOT NULL,
  `ContactRelationship` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Department` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `ID` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `managerID` CHAR(20) NOT NULL,
  `Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Bank_name`),
  INDEX `fk_Department_Bank_idx` (`Bank_name` ASC) VISIBLE,
  CONSTRAINT `fk_Department_Bank`
    FOREIGN KEY (`Bank_name`)
    REFERENCES `mydb`.`Bank` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `ID` VARCHAR(20) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `JoinDate` DATE NULL,
  `Department_ID` VARCHAR(10) NOT NULL,
  `Department_Bank_name` VARCHAR(45) NOT NULL,
  `StaffType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Department_ID`, `Department_Bank_name`),
  INDEX `fk_staff_Department1_idx` (`Department_ID` ASC, `Department_Bank_name` ASC) VISIBLE,
  CONSTRAINT `fk_staff_Department1`
    FOREIGN KEY (`Department_ID` , `Department_Bank_name`)
    REFERENCES `mydb`.`Department` (`ID` , `Bank_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CostumerService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CostumerService` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CostumerService` (
  `Type` VARCHAR(20) NOT NULL,
  `staff_ID` VARCHAR(20) NOT NULL,
  `Costumer_ID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`staff_ID`, `Costumer_ID`, `Type`),
  INDEX `fk_CostumerService_Costumer1_idx` (`Costumer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_CostumerService_staff1`
    FOREIGN KEY (`staff_ID`)
    REFERENCES `mydb`.`staff` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CostumerService_Costumer1`
    FOREIGN KEY (`Costumer_ID`)
    REFERENCES `mydb`.`Costumer` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SavingAccounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SavingAccounts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SavingAccounts` (
  `ID` VARCHAR(45) NOT NULL,
  `Savings` DECIMAL(15,2) NOT NULL,
  `OpenDate` DATE NOT NULL,
  `CheckinDate` DATE NOT NULL,
  `Ratio` VARCHAR(45) NOT NULL,
  `CoinType` VARCHAR(45) NOT NULL,
  `Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Bank_name`),
  INDEX `fk_SavingAccounts_Bank1_idx` (`Bank_name` ASC) VISIBLE,
  CONSTRAINT `fk_SavingAccounts_Bank1`
    FOREIGN KEY (`Bank_name`)
    REFERENCES `mydb`.`Bank` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CheckAccounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CheckAccounts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CheckAccounts` (
  `ID` VARCHAR(45) NOT NULL,
  `Savings` DECIMAL(15,2) NOT NULL,
  `OpenDate` DATE NOT NULL,
  `CheckinDate` DATE NOT NULL,
  `DrawLeft` DECIMAL(15,2) NOT NULL,
  `Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Bank_name`),
  INDEX `fk_CheckAccounts_Bank1_idx` (`Bank_name` ASC) VISIBLE,
  CONSTRAINT `fk_CheckAccounts_Bank1`
    FOREIGN KEY (`Bank_name`)
    REFERENCES `mydb`.`Bank` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Loans` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Loans` (
  `ID` VARCHAR(45) NOT NULL,
  `Amount` DECIMAL(20,2) NOT NULL,
  `Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Loans_Bank1_idx` (`Bank_name` ASC) VISIBLE,
  CONSTRAINT `fk_Loans_Bank1`
    FOREIGN KEY (`Bank_name`)
    REFERENCES `mydb`.`Bank` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costumer_has_Loans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Costumer_has_Loans` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Costumer_has_Loans` (
  `Costumer_ID` VARCHAR(20) NOT NULL,
  `Loans_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Costumer_ID`, `Loans_ID`),
  INDEX `fk_Costumer_has_Loans_Loans1_idx` (`Loans_ID` ASC) VISIBLE,
  INDEX `fk_Costumer_has_Loans_Costumer1_idx` (`Costumer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Costumer_has_Loans_Costumer1`
    FOREIGN KEY (`Costumer_ID`)
    REFERENCES `mydb`.`Costumer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Costumer_has_Loans_Loans1`
    FOREIGN KEY (`Loans_ID`)
    REFERENCES `mydb`.`Loans` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LoansDetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LoansDetail` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LoansDetail` (
  `PayAmount` DECIMAL(20,2) NOT NULL,
  `PayDay` DATE NOT NULL,
  `PaySeq` INT NOT NULL,
  `Loans_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PaySeq`, `Loans_ID`),
  INDEX `fk_LoansDetail_Loans1_idx` (`Loans_ID` ASC) VISIBLE,
  CONSTRAINT `fk_LoansDetail_Loans1`
    FOREIGN KEY (`Loans_ID`)
    REFERENCES `mydb`.`Loans` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costumer_has_SavingAccounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Costumer_has_SavingAccounts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Costumer_has_SavingAccounts` (
  `Costumer_ID` VARCHAR(20) NOT NULL,
  `SavingAccounts_ID` VARCHAR(45) NOT NULL,
  `SavingAccounts_Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Costumer_ID`, `SavingAccounts_Bank_name`),
  INDEX `fk_Costumer_has_SavingAccounts_SavingAccounts1_idx` (`SavingAccounts_ID` ASC, `SavingAccounts_Bank_name` ASC) VISIBLE,
  INDEX `fk_Costumer_has_SavingAccounts_Costumer1_idx` (`Costumer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Costumer_has_SavingAccounts_Costumer1`
    FOREIGN KEY (`Costumer_ID`)
    REFERENCES `mydb`.`Costumer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Costumer_has_SavingAccounts_SavingAccounts1`
    FOREIGN KEY (`SavingAccounts_ID` , `SavingAccounts_Bank_name`)
    REFERENCES `mydb`.`SavingAccounts` (`ID` , `Bank_name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costumer_has_CheckAccounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Costumer_has_CheckAccounts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Costumer_has_CheckAccounts` (
  `Costumer_ID` CHAR(20) NOT NULL,
  `CheckAccounts_ID` VARCHAR(45) NOT NULL,
  `CheckAccounts_Bank_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Costumer_ID`, `CheckAccounts_Bank_name`),
  INDEX `fk_Costumer_has_CheckAccounts_CheckAccounts1_idx` (`CheckAccounts_ID` ASC, `CheckAccounts_Bank_name` ASC) VISIBLE,
  INDEX `fk_Costumer_has_CheckAccounts_Costumer1_idx` (`Costumer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Costumer_has_CheckAccounts_Costumer1`
    FOREIGN KEY (`Costumer_ID`)
    REFERENCES `mydb`.`Costumer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Costumer_has_CheckAccounts_CheckAccounts1`
    FOREIGN KEY (`CheckAccounts_ID` , `CheckAccounts_Bank_name`)
    REFERENCES `mydb`.`CheckAccounts` (`ID` , `Bank_name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
