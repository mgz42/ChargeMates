// app/javascript/controllers/index.js
import { Application } from '@hotwired/stimulus'
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete)
// Configure Stimulus development experience
application.debug = false;

export { application };
