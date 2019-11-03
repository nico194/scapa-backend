const { get , getById, insert, update, del} = require('./connection');

const getPhrases = (req, res) => {
    get('phrases')
        .then( response => res.status(200).json(response))
        .catch( err => { throw err })
}

const getPhrasesByPatient = async (req, res) => {
    const folder = await getById('folders', req.params.id, 'patient_id', 'id');
    const phrasesInFolder = await getById('phrases_folder', folder[0].id, 'folder_id', 'phrase_id');
    const phrases = [];
    for (const phraseId of phrasesInFolder) {
        const phrase = await getById('phrases', phraseId.phrase_id);
        phrases.push(phrase[0]);
    }
    const sendPhrases = [];
    for( const phrase of phrases) {
        const pictogramsInPhrase = await getById('pictograms_phrase', phrase.id, 'phrase_id');
        const pictograms = [];
        for( const pictogramInPhrase of pictogramsInPhrase) {
            console.log('pictogramInPhrase', pictogramInPhrase)
            const pictogram = await getById('pictograms', pictogramInPhrase.pictogram_id);
            pictograms.push(pictogram[0])
        }
        phrase['pictograms'] = pictograms;
        sendPhrases.push(phrase);
    }
    res.status(200).json(sendPhrases)
}

const createPhrases = async (req, res) => {
    console.log('body', req.body)
    const folder = await getById('folders', req.params.id, 'patient_id', 'id');
    const idFolder = folder[0].id;
    const phrase = await insert('phrases', { type: req.body.type })
    const idPhrase = phrase.id;
    await insert('phrases_folder', { folder_id: idFolder, phrase_id: idPhrase });
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
    del('phrases', req.params)
        .then( response => response ? res.status(200).json({ 'delete': 'success'}) : res.status(500).json({ err: 'error'}))
        .catch( err => { throw err });
}

module.exports = {
    getPhrases,
    createPhrases,
    updatePhrases,
    deletePhrases,
    getPhrasesByPatient    
}