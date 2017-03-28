CREATE DEFINER=`root`@`%` PROCEDURE `insert_address`(
	country varchar(45),
    region varchar(45),
    populated_area varchar(45), 
    populated_area_type_id int,
    municipality varchar(45),
    postal_code varchar(45),
    street varchar(45),
    street_number varchar(45),
    floor int,
    apartmentNo int
)
BEGIN
	INSERT INTO `countries` (`name`)
    SELECT country FROM countries
    WHERE NOT EXISTS (SELECT * FROM `countries` WHERE name = country)
    LIMIT 1;
    SET @id = (SELECT `id` FROM `countries` WHERE name = country);
    
    INSERT INTO `regions` (`name`, `country_id`)
    SELECT region, @id FROM `regions`
    WHERE NOT EXISTS (SELECT * FROM `regions` WHERE name = region AND `country_id` = @id)
    LIMIT 1;
    SET @id = (SELECT `id` from `regions` WHERE name = region AND `country_id` = @id);
    
    INSERT INTO `populated_areas` (`name`, `type_id`, `region_id`)
    SELECT populated_area, populated_area_type_id, @id FROM `populated_areas`
    WHERE NOT EXISTS (SELECT * FROM `populated_areas` WHERE name = populated_area AND `type_id` = populated_area_type_id AND `region_id` = @id)
    LIMIT 1;
    SET @id = (SELECT `id` from `populated_areas` WHERE name = populated_area AND `type_id` = populated_area_type_id AND `region_id` = @id);
    
    INSERT INTO `municipalities` (`name`, `postal_code`, `populated_area_id`)
    SELECT municipality, postal_code, @id FROM `municipalities`
    WHERE NOT EXISTS (SELECT * FROM `municipalities` WHERE name = municipality AND `postal_code` = postal_code AND `populated_area_id` = @id)
    LIMIT 1;
    SET @id = (SELECT `id` from `municipalities` WHERE name = municipality AND `postal_code` = postal_code AND `populated_area_id` = @id);
    
    INSERT INTO `streets` (`name`, `municipality_id`)
    SELECT street, @id FROM `streets`
    WHERE NOT EXISTS (SELECT * FROM `streets` WHERE name = street AND `municipality_id` = @id)
    LIMIT 1;
    SET @id = (SELECT `id` from `streets` WHERE name = street AND `municipality_id` = @id);
    
    INSERT INTO `addresses` (`street_id`, `number`, `floor`, `apartmentNo`)
    SELECT @id, street_number, floor, apartmentNo FROM `addresses`
    WHERE NOT EXISTS (SELECT * FROM `addresses` WHERE `street_id` = @id AND `number` = street_number AND `floor` = floor AND `apartmentNo` = apartmentNo)
    LIMIT 1;
    SET @id = (SELECT `id` FROM `addresses` WHERE `street_id` = @id AND `number` = street_number AND `floor` = floor AND `apartmentNo` = apartmentNo);
    
    SELECT @id;
END