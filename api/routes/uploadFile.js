module.exports = {
    upload: function(dest) {
        const multer = require('multer');
        const storage = multer.diskStorage({
            destination: function(req, file, cb) {
                cb(null, dest);
            },
            filename: function(req, file, cb) {
                cb(null, Date.now() + file.originalname);
            }
        });


        const fileFilter = (req, file, cb) => {
            if(file.mimetype === 'image/jpg' || file.mimetype === 'image/jpeg' || file.mimetype === 'image/png'){
                cb(null, true);
            } else {
                cb(null, false);
            }
        };
        
        const upload = multer({
            storage: storage,
            limits: {
                fileSize: 10264 * 1024 * 5
            },
            fileFilter: fileFilter
        });

        return upload;
    }
}