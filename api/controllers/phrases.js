const { get , getById, insert, update, del} = require('./connection');

const getPhrases = (req, res) => {
    get('phrases')
        .then( response => res.status(200).json(response))
        .catch( err => { throw err })
}

const createPhrases = async (req, res) => {
    const folder = await getById('folders', req.params.id, 'patient_id', 'id');
    const idFolder = folder[0].id;
    const phrase = await insert('phrases', { type: req.body.type })
    const idPhrase = phrase.id;
    await insert('phrases-folder', { folder_id: idFolder, phrase_id: idPhrase });
    let pictograms = req.body.pictograms;
    console.log('add pictograms: ', pictograms)
    let newPictograms = [];
    console.log(pictograms, idPhrase);
    for(let pictogram of pictograms) {
        console.log(pictogram)
        await insert('pictograms_phrase',
            {
                phrase_id: idPhrase,
                pictogram_id: pictogram
            },
        );
        const pictogramAdded = await getById('pictograms', pictogram)
        newPictograms.push(pictogramAdded[0]);
    }
    res.status(201).json({insert: 'success', pictograms: newPictograms})
}

const updatePhrases = (req, res) => {
    
}

const deletePhrases = (req, res) => {
    
}

module.exports = {
    getPhrases,
    createPhrases,
    updatePhrases,
    deletePhrases    
}