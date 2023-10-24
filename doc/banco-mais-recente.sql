-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema STPSP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema STPSP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `STPSP` DEFAULT CHARACTER SET utf8 ;
USE `STPSP` ;

-- -----------------------------------------------------
-- Table `STPSP`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(14) NOT NULL,
  `nomeCompleto` VARCHAR(45) NOT NULL,
  `acompanhante` VARCHAR(45) NULL,
  `acompanha` VARCHAR(45) NULL,
  `deficiencia` VARCHAR(45) NULL,
  `email` VARCHAR(100) NOT NULL,
  `nascimento` DATE NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `numeroTel` VARCHAR(20) NOT NULL,
  `tipoCarteirinha` VARCHAR(45) NOT NULL,
  `saldo` DECIMAL(10,2) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`motorista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(14) NOT NULL,
  `nomeCompleto` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `nascimento` DATE NOT NULL,
  `numeroTel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`linha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`linha` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `localSaida` VARCHAR(45) NOT NULL,
  `localDestino` VARCHAR(45) NOT NULL,
  `horaSaida` TIME NOT NULL,
  `horaChegada` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`onibus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`onibus` (
  `numero` INT NOT NULL AUTO_INCREMENT,
  `placa` CHAR(7) NOT NULL,
  `linha_id` INT NOT NULL,
  PRIMARY KEY (`numero`, `linha_id`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC),
  INDEX `fk_onibus_linha1_idx` (`linha_id` ASC),
  CONSTRAINT `fk_onibus_linha1`
    FOREIGN KEY (`linha_id`)
    REFERENCES `STPSP`.`linha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`motorista_onibus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`motorista_onibus` (
  `id` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `onibus_numero1` INT NOT NULL,
  `motorista_id` INT NOT NULL,
  PRIMARY KEY (`id`, `onibus_numero1`, `motorista_id`),
  INDEX `fk_motorista_onibus_onibus2_idx` (`onibus_numero1` ASC),
  INDEX `fk_motorista_onibus_motorista1_idx` (`motorista_id` ASC),
  CONSTRAINT `fk_motorista_onibus_onibus2`
    FOREIGN KEY (`onibus_numero1`)
    REFERENCES `STPSP`.`onibus` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_motorista_onibus_motorista1`
    FOREIGN KEY (`motorista_id`)
    REFERENCES `STPSP`.`motorista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`viagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `linha_id` INT NOT NULL,
  `onibus_numero` INT NOT NULL,
  `onibus_linha_id` INT NOT NULL,
  `motorista_id` INT NOT NULL,
  PRIMARY KEY (`id`, `linha_id`, `onibus_numero`, `onibus_linha_id`, `motorista_id`),
  INDEX `fk_viagem_linha1_idx` (`linha_id` ASC),
  INDEX `fk_viagem_onibus1_idx` (`onibus_numero` ASC, `onibus_linha_id` ASC),
  INDEX `fk_viagem_motorista1_idx` (`motorista_id` ASC),
  CONSTRAINT `fk_viagem_linha1`
    FOREIGN KEY (`linha_id`)
    REFERENCES `STPSP`.`linha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_onibus1`
    FOREIGN KEY (`onibus_numero` , `onibus_linha_id`)
    REFERENCES `STPSP`.`onibus` (`numero` , `linha_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_motorista1`
    FOREIGN KEY (`motorista_id`)
    REFERENCES `STPSP`.`motorista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `STPSP`.`viagem_has_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `STPSP`.`viagem_has_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `viagem_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `tarifa` DECIMAL(10,2) NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `viagem_id`, `cliente_id`),
  INDEX `fk_viagem_has_cliente_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_viagem_has_cliente_viagem1_idx` (`viagem_id` ASC),
  CONSTRAINT `fk_viagem_has_cliente_viagem1`
    FOREIGN KEY (`viagem_id`)
    REFERENCES `STPSP`.`viagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_has_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `STPSP`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
