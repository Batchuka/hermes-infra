CREATE DATABASE IF NOT EXISTS contracts;
CREATE USER IF NOT EXISTS 'contracts'@'%' IDENTIFIED BY 'contracts';
GRANT ALL PRIVILEGES ON contracts.* TO 'contracts'@'%';