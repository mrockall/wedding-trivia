import assets from 'church-jump/assets'

const AudioContext = window.AudioContext || window.webkitAudioContext
const audioContext = new AudioContext()
const soundNames = ['game_over', 'jump', 'level_up']
const soundBuffers = {}
let SOUNDS_LOADED = false

loadSounds().catch(console.error)
export function playSound(name) {
  if (SOUNDS_LOADED) {
    audioContext.resume()
    playBuffer(soundBuffers[name])
  }
}

async function loadSounds() {
  await Promise.all(
    soundNames.map(async (soundName) => {
      soundBuffers[soundName] = await loadBuffer(assets[`${soundName}_mp3`])
    })
  )

  SOUNDS_LOADED = true
}

function loadBuffer(filepath) {
  return new Promise((resolve, reject) => {
    const request = new XMLHttpRequest()

    request.open('GET', filepath)
    request.responseType = 'arraybuffer'
    request.onload = () =>
      audioContext.decodeAudioData(request.response, resolve)
    request.onerror = reject
    request.send()
  })
}

function playBuffer(buffer) {
  const source = audioContext.createBufferSource()

  source.buffer = buffer
  source.connect(audioContext.destination)
  source.start()
}
