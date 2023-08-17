-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inst327project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `inst327project` ;

-- -----------------------------------------------------
-- Schema inst327project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inst327project` DEFAULT CHARACTER SET utf8 ;
USE `inst327project` ;

-- -----------------------------------------------------
-- Table `inst327project`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`company` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`company` (
  `company_id` INT NOT NULL,
  `company_size_from` INT NOT NULL,
  `company_size_to` INT NOT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`salary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`salary` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`salary` (
  `salary_id` INT NOT NULL,
  `currency` VARCHAR(4) NULL,
  `salary_to` INT NULL,
  `salary_from` INT NULL,
  PRIMARY KEY (`salary_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`position` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`position` (
  `position_id` INT NOT NULL,
  `date_posted` DATE NOT NULL,
  `marker_icon` VARCHAR(45) NOT NULL,
  `company_id` INT NOT NULL,
  `salary_id` INT NOT NULL,
  PRIMARY KEY (`position_id`),
  INDEX `fk_position_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_position_salary1_idx` (`salary_id` ASC) VISIBLE,
  CONSTRAINT `fk_position_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `inst327project`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_position_salary1`
    FOREIGN KEY (`salary_id`)
    REFERENCES `inst327project`.`salary` (`salary_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`title` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`title` (
  `title_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`title_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`company_position_title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`company_position_title` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`company_position_title` (
  `title_id` INT NOT NULL,
  `remote` TINYINT NULL,
  `experience` VARCHAR(45) NULL,
  `position_position_id` INT NOT NULL,
  INDEX `fk_company_position_title_title1_idx` (`title_id` ASC) VISIBLE,
  INDEX `fk_company_position_title_position1_idx` (`position_position_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_position_title_title1`
    FOREIGN KEY (`title_id`)
    REFERENCES `inst327project`.`title` (`title_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_position_title_position1`
    FOREIGN KEY (`position_position_id`)
    REFERENCES `inst327project`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`location` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`location` (
  `location_id` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`company_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`company_location` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`company_location` (
  `location_id` INT NOT NULL,
  `company_id` INT NOT NULL,
  INDEX `fk_company_location_location1_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_company_location_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_location_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `inst327project`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_location_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `inst327project`.`company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`requirements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`requirements` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`requirements` (
  `requirement_id` INT NOT NULL,
  `skill_name` VARCHAR(45) NULL,
  PRIMARY KEY (`requirement_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inst327project`.`position_requirement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inst327project`.`position_requirement` ;

CREATE TABLE IF NOT EXISTS `inst327project`.`position_requirement` (
  `skill_value` INT NULL,
  `position_id` INT NOT NULL,
  `requirement_id` INT NOT NULL,
  INDEX `fk_position_requirement_position1_idx` (`position_id` ASC) VISIBLE,
  INDEX `fk_position_requirement_requirements1_idx` (`requirement_id` ASC) VISIBLE,
  CONSTRAINT `fk_position_requirement_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `inst327project`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_position_requirement_requirements1`
    FOREIGN KEY (`requirement_id`)
    REFERENCES `inst327project`.`requirements` (`requirement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
