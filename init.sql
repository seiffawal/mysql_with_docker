-- Create keyring if not exists
CREATE TABLE IF NOT EXISTS mysql.keyring (
    keyring_name VARCHAR(255) NOT NULL,
    keyring_key_id VARCHAR(255) NOT NULL,
    keyring_key VARCHAR(512) NOT NULL,
    PRIMARY KEY (keyring_name, keyring_key_id)
) ENGINE=InnoDB;

-- Insert encryption key into MySQL keyring
INSERT INTO mysql.keyring (keyring_name, keyring_key_id, keyring_key)
VALUES ('keyring_encryption', 'key1', 'your_encryption_key_here');

-- Create users table with hashed passwords and encrypted card numbers
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(1024) NOT NULL,
    password_hash CHAR(64) NOT NULL, -- SHA-256 hash
    cardnumber VARBINARY(2048) NOT NULL
) ENGINE=InnoDB;

-- Insert sample data into users table with hashed passwords and encrypted card numbers
INSERT INTO users (username, password_hash, cardnumber) VALUES
    ('john_doe', SHA2('password123', 256), AES_ENCRYPT('1234567890123456', 'your_encryption_key_here')),
    ('jane_smith', SHA2('secret456', 256), AES_ENCRYPT('9876543210987654', 'your_encryption_key_here')),
    ('alice_jones', SHA2('pass123word', 256), AES_ENCRYPT('5678901234567890', 'your_encryption_key_here'));
