// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "../css/application.css"
import "../css/font-awesome.scss"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("turbolinks:load", function() {
  pronounce()
});

window.pronounce = function() {
  let el = document.getElementById("list_name")

  if (el != undefined) {
    let word  = el.dataset.word
    let voice = el.dataset.voice

    el.focus()
    responsiveVoice.speak(word, voice)

    let form = document.getElementById("list_form")
    form.onsubmit = function() {
      if (el.value == "") {
        responsiveVoice.speak(word, voice)
        return false
      } else {
        spell(word, voice)
        return false
      }
    }
  }
}

async function spell(word, voice) {
  let letters = word.split('')
  let form    = document.getElementById("list_form")

  for (let i = 0; i < letters.length; i++) {
    responsiveVoice.speak(letters[i], voice)
    await sleep(1000)
  }

  responsiveVoice.speak(word, voice)
  await sleep(1500)

  form.submit()
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
