import { Elm } from './Main.elm'
// import 'regenerator-runtime/runtime'

let app = Elm.Main.init({
  node: document.querySelector('main'),
  flags: {players: JSON.parse(localStorage.getItem('players'))}
})


app.ports.setState.subscribe(async (players) => {
    console.log("players", players)
    localStorage.setItem('players', JSON.stringify(players))
})

