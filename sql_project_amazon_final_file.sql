-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema amazon_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema amazon_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `amazon_database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `amazon_database` ;

-- -----------------------------------------------------
-- Table `amazon_database`.`login_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`login_detail` (
  `login_sno` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`login_sno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`customer` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `login detail_s_no` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`cid`),
  INDEX `fk_customer_login detail_idx` (`login detail_s_no` ASC) VISIBLE,
  CONSTRAINT `fk_customer_login detail`
    FOREIGN KEY (`login detail_s_no`)
    REFERENCES `amazon_database`.`login_detail` (`login_sno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`seller` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `login__sno` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `company` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `description` VARCHAR(45) NULL,
  `sellercol` VARCHAR(45) NOT NULL,
  `rating` INT NULL,
  PRIMARY KEY (`sid`, `sellercol`),
  INDEX `fk_seller_login detail1_idx` (`login__sno` ASC) VISIBLE,
  CONSTRAINT `fk_seller_login detail1`
    FOREIGN KEY (`login__sno`)
    REFERENCES `amazon_database`.`login_detail` (`login_sno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`category` (
  `idcategory` INT NOT NULL,
  `seller_sid` INT NOT NULL,
  `category_name` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategory`),
  INDEX `fk_category_seller1_idx` (`seller_sid` ASC) VISIBLE,
  CONSTRAINT `fk_category_seller1`
    FOREIGN KEY (`seller_sid`)
    REFERENCES `amazon_database`.`seller` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`product` (
  `idproduct` INT NOT NULL AUTO_INCREMENT,
  `idcategory` INT NOT NULL,
  `seller_sid` INT NOT NULL,
  `product_category` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `rating` INT NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `instock` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproduct`),
  INDEX `fk_product_category1_idx` (`idcategory` ASC) VISIBLE,
  UNIQUE INDEX `idproduct_UNIQUE` (`idproduct` ASC) VISIBLE,
  INDEX `fk_product_seller1_idx` (`seller_sid` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`idcategory`)
    REFERENCES `amazon_database`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_seller1`
    FOREIGN KEY (`seller_sid`)
    REFERENCES `amazon_database`.`seller` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`payment` (
  `idpayment` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`delivered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`delivered` (
  `iddelivered` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `address` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`iddelivered`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`order` (
  `idorder` INT NOT NULL AUTO_INCREMENT,
  `customer_cid` INT NOT NULL,
  `payment_idpayment` INT NOT NULL,
  `delivered_iddelivered` INT NOT NULL,
  `product_idproduct` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `mode_idmode` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idorder`, `product_idproduct`),
  INDEX `fk_order_customer1_idx` (`customer_cid` ASC) VISIBLE,
  INDEX `fk_order_payment1_idx` (`payment_idpayment` ASC) VISIBLE,
  INDEX `fk_order_delivered1_idx` (`delivered_iddelivered` ASC) VISIBLE,
  INDEX `fk_order_product1_idx` (`product_idproduct` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_cid`)
    REFERENCES `amazon_database`.`customer` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment1`
    FOREIGN KEY (`payment_idpayment`)
    REFERENCES `amazon_database`.`payment` (`idpayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_delivered1`
    FOREIGN KEY (`delivered_iddelivered`)
    REFERENCES `amazon_database`.`delivered` (`iddelivered`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_product1`
    FOREIGN KEY (`product_idproduct`)
    REFERENCES `amazon_database`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`cart` (
  `idcart` INT NOT NULL,
  `product_idproduct` INT NOT NULL,
  `order_idorder` INT NOT NULL,
  `items` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcart`),
  INDEX `fk_cart_product1_idx` (`product_idproduct` ASC) VISIBLE,
  INDEX `fk_cart_order1_idx` (`order_idorder` ASC) VISIBLE,
  CONSTRAINT `fk_cart_product1`
    FOREIGN KEY (`product_idproduct`)
    REFERENCES `amazon_database`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_order1`
    FOREIGN KEY (`order_idorder`)
    REFERENCES `amazon_database`.`order` (`idorder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amazon_database`.`quantiy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `amazon_database`.`quantiy` (
  `idquantiy` INT NOT NULL,
  `order_idorder` INT NOT NULL,
  `cart_idcart` INT NOT NULL,
  `item_quantity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idquantiy`),
  INDEX `fk_quantiy_order1_idx` (`order_idorder` ASC) VISIBLE,
  INDEX `fk_quantiy_cart1_idx` (`cart_idcart` ASC) VISIBLE,
  CONSTRAINT `fk_quantiy_order1`
    FOREIGN KEY (`order_idorder`)
    REFERENCES `amazon_database`.`order` (`idorder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_quantiy_cart1`
    FOREIGN KEY (`cart_idcart`)
    REFERENCES `amazon_database`.`cart` (`idcart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
