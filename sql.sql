CREATE TABLE `ped` (
`identifier` varchar(50) NOT NULL,
`ped` varchar(50) NOT NULL,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4