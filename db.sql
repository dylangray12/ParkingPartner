CREATE TABLE IF NOT EXISTS messages (
    message_id    INT(11)         NOT NULL AUTO_INCREMENT,
    timestamp     DATE            NOT NULL,
    sender        VARCHAR(145)    NOT NULL,
    recipient     VARCHAR(145)    NOT NULL,
    message       VARCHAR(145)    NOT NULL,
    PRIMARY KEY (message_id)
);

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), 'Me', 'You', 'Hi!');

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), 'Bob', 'Says', 'Hi!');

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), 'Mary', 'Greeted', 'Brad!');

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), 'Pasta', 'Is', 'Good!');

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), 'He', 'Makes', 'Food!');

SELECT message_id, timestamp, sender, recipient, message
FROM messages;

UPDATE messages
SET sender = 'You', recipient = 'Me', message = 'Bye¿'
WHERE message_id = 1;

SELECT message_id, timestamp, sender, recipient, message
FROM messages;

DELETE FROM messages
WHERE message_id = 1;

SELECT COUNT(message) AS "NumMessages"
FROM messages;
