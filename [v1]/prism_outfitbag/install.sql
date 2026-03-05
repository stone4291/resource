 CREATE TABLE IF NOT EXISTS `prism_outfits` (
      `id` INT NOT NULL AUTO_INCREMENT,
      `identifier` VARCHAR(60) NOT NULL,
      `outfitname` VARCHAR(50) NOT NULL,
      `outfit` LONGTEXT NOT NULL,
      PRIMARY KEY (`id`),
      INDEX `identifier` (`identifier`)
  );