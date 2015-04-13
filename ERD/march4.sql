-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `uId` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `pw` VARCHAR(45) NULL,
  PRIMARY KEY (`uId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`quest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`quest` ;

CREATE TABLE IF NOT EXISTS `mydb`.`quest` (
  `qId` INT NOT NULL,
  `pid` VARCHAR(45) NULL,
  `posX` INT NULL,
  `poxY` INT NULL,
  `order` VARCHAR(45) NULL,
  `contents` TEXT NULL,
  `due` TIME NULL,
  PRIMARY KEY (`qId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`project` ;

CREATE TABLE IF NOT EXISTS `mydb`.`project` (
  `pId` INT NOT NULL,
  `uId` INT NULL,
  `name` VARCHAR(45) NULL,
  `shared` VARCHAR(45) NULL,
  PRIMARY KEY (`pId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`participate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`participate` ;

CREATE TABLE IF NOT EXISTS `mydb`.`participate` (
  `uId` INT NOT NULL,
  `pId` INT NOT NULL,
  `posX` INT NULL,
  `posY` INT NULL,
  PRIMARY KEY (`uId`, `pId`),
  INDEX `fk_user_has_project_project1_idx` (`pId` ASC),
  INDEX `fk_user_has_project_user_idx` (`uId` ASC),
  CONSTRAINT `fk_user_has_project_user`
    FOREIGN KEY (`uId`)
    REFERENCES `mydb`.`user` (`uId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_project_project1`
    FOREIGN KEY (`pId`)
    REFERENCES `mydb`.`project` (`pId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`complete`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`complete` ;

CREATE TABLE IF NOT EXISTS `mydb`.`complete` (
  `uId` INT NOT NULL,
  `pId` INT NOT NULL,
  PRIMARY KEY (`uId`, `pId`),
  INDEX `fk_user_has_quest_quest1_idx` (`pId` ASC),
  INDEX `fk_user_has_quest_user1_idx` (`uId` ASC),
  CONSTRAINT `fk_user_has_quest_user1`
    FOREIGN KEY (`uId`)
    REFERENCES `mydb`.`user` (`uId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_quest_quest1`
    FOREIGN KEY (`pId`)
    REFERENCES `mydb`.`quest` (`qId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`invite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`invite` ;

CREATE TABLE IF NOT EXISTS `mydb`.`invite` (
  `host_uId` INT NOT NULL,
  `guest_uId` INT NOT NULL,
  `pId` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`host_uId`, `guest_uId`, `pId`),
  INDEX `fk_user_has_user_user2_idx` (`guest_uId` ASC),
  INDEX `fk_user_has_user_user1_idx` (`host_uId` ASC),
  INDEX `fk_invite_project1_idx` (`pId` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`host_uId`)
    REFERENCES `mydb`.`user` (`uId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`guest_uId`)
    REFERENCES `mydb`.`user` (`uId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invite_project1`
    FOREIGN KEY (`pId`)
    REFERENCES `mydb`.`project` (`pId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
