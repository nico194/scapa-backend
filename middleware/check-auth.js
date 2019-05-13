const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    try {
        const token = req.header.authorization.split(' ')[1];
        const decoded = jwt.verify(token, 'secret');
        req.userData = decoded;
    } catch (error) {
        return res.status(401).json({
            message: 'Auth Failed - Token error'
        });
    }
}
