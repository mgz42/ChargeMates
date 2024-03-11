import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="roue"
export default class extends Controller {

  static targets = ["boutonroue1", "boutonroue2","boutonroue3","boutonroue4","popuproue"];

  connect() {
    getcontext();
    init();
  }

  lance_roue(){
    this.boutonroue1Target.classList.toggle("d-none");
    this.boutonroue2Target.classList.toggle("d-none");
    start = true; init();
    const stop_the_wheel = () => {
    this.boutonroue3Target.classList.toggle("d-none");
    this.boutonroue4Target.classList.toggle("d-none");
    }
    setTimeout(stop_the_wheel, 1600);
  }

  stop_roue(){
    mafonction();
  }

  close_popup(){
    this.popuproueTarget.classList.toggle("d-none");
  };

  disconnect(){
    console.log("goodbye")
  }
}

// general content

let ctx = "";
const getcontext = () => {
  ctx = document.querySelector("#laroue").getContext("2d");
}

const hash_of_badges = { "#579b66": "double_xp", "#d3396e": "freeze_week", "#877cc7": "freeze_month", "#f34a47" : "minus_one_euro","#ffc114" : "level_up", "#aea98c" : "none", "#ff983a": "cristal", "#79b0cf": "weekly_special" };
const hash_de_noms = {"double_xp": "Double XP 24 heures", "freeze_week" : "Gel de série une semaine", "freeze_month" : "Gel de série un mois", "minus_one_euro" : "Moins un euro sur votre prochaine commande", "level_up": "Plus un niveau", "cristal" : "Cristal", "weekly_special" : "Badge de la semaine"};

const give_the_result = (color) => {
  let texte_popup = "Malheuresement, vous n'avez pas gagné de bonus aujourd'huis. Revenez demain !";

  if (hash_of_badges[color] !== "none"){
    texte_popup = "Félicitation, vous avec gagné un bonus:";
    document.getElementById("bonus-popup-roue").innerHTML = hash_de_noms[hash_of_badges[color]] + " !";
  }

  document.getElementById("texte-du-popup-roue").innerHTML = texte_popup;

  setTimeout(() => {
    document.getElementById("dark-behind").classList.toggle("d-none");
  }, 500);

  let date = new Date();

  fetch("/users/1", {
    method: "PATCH",
    headers: { "Accept": "application/json" },
    body: JSON.stringify({user: {
      wheel: date
    }})
  })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })

  fetch("/badges", {
    method: "POST",
    headers: { "Accept": "application/json" },
    body: JSON.stringify({badge: {name: hash_of_badges[color]}})
  })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })

    // indique le badge gagné
    console.log(hash_of_badges[color]);
}

const init = () => {
    window.requestAnimationFrame(draw);
}

let speed = 1;
let accelerate = true;
let stopper = false;
let randomslow = 0.02;
let start = false;
// au dessus variable tout le monde.


const draw = () => {

    ctx.clearRect(0, 0, 1000, 1000);

    if (speed < 10 && accelerate === true){
        speed *= 1.03;
    } else if (speed >= 10 && accelerate === true){
        accelerate = false;
    } else if( speed > 0 && stopper === true){
        speed -= speed * randomslow;
        if (speed < 0){
            speed = 0;
        }
    }

    if (Math.abs(array_triangles[0].angle) < 360){
        array_triangles[0].angle -= speed;
    } else if (Math.abs(array_triangles[0].angle) >= 360){
        array_triangles[0].angle = 0;
    }

    array_triangles.forEach((triangle)=>{

        if (triangle.numero != 0){
            triangle.angle = array_triangles[0].angle + (45 * triangle.numero);
        }

        // ctx.strokeStyle = triangle.color;
        // ctx.beginPath();
        // ctx.moveTo(500 + 500 * Math.cos(-triangle.angle*Math.PI/180), 500 + 500 * Math.sin(-triangle.angle*Math.PI/180));
        // ctx.lineTo(500, 500);
        // ctx.stroke();

        // let angle_end = triangle.angle + 45 > 360 ? triangle.angle + 45 - 360 : triangle.angle + 45;

        // ctx.beginPath();
        // ctx.moveTo(500 + 500 * Math.cos(-angle_end*Math.PI/180), 500 + 500 * Math.sin(-angle_end*Math.PI/180));
        // ctx.lineTo(500, 500);
        // ctx.stroke();


        ctx.fillStyle = triangle.color;
        ctx.beginPath();
        ctx.moveTo(500, 500);
        ctx.arc(500,500,500, Math.PI*2*(triangle.angle/360) , Math.PI*2*(triangle.angle/360) + (Math.PI*2*0.125));
        ctx.lineTo(500,500);
        ctx.fill();

        ctx.lineWidth = 7;
        ctx.strokeStyle = "#f5f4f0";
        ctx.stroke();
        ctx.fillStyle = "black";
        ctx.rotate(0.2);
        ctx.font ="48px sans-serif";
        ctx.fillText(hash_of_badges[triangle.color], 600, 490);
        ctx.rotate(-0.2);
    })

    ctx.beginPath();
    ctx.arc(500, 500, 80, 0, Math.PI * 2)
    ctx.fillStyle = "rgba(0,0,0,0.2)";
    ctx.fill();

    ctx.beginPath();
    ctx.arc(500, 500, 60, 0, Math.PI * 2)
    ctx.fillStyle = "#f5f4f0";
    ctx.fill();

    //details esthetiques
    ctx.filter = "blur(20px)";
    ctx.beginPath();
    ctx.arc(500, 500, 460, 0, Math.PI * 2)
    ctx.strokeStyle = "rgba(0,0,0,0.2)";
    ctx.lineWidth = 28;
    ctx.stroke();
    ctx.filter = "blur(0px)";


    ctx.beginPath();
    ctx.arc(500, 500, 488, 0, Math.PI * 2)
    ctx.strokeStyle = "#f5f4f0"
    ctx.lineWidth = 28;
    ctx.stroke();

    if (!Math.floor(speed)<= 0 && start === true ){window.requestAnimationFrame(draw);} else if (start === true){
        console.log("La roue s'arrete !")
        array_triangles.forEach((triangle)=>{
        let angle_end = triangle.angle + 45 > 360 ? triangle.angle + 45 - 360 : triangle.angle + 45;
            if (500 + 500 * Math.cos(-triangle.angle*Math.PI/180) <= 500 && 500 + 500 * Math.cos(-angle_end*Math.PI/180) >= 500 && 500 + 500 * Math.sin(-triangle.angle*Math.PI/180) > 500){
                give_the_result(triangle.color);
            }
        })
    }
}

class Triangle{
    constructor(numero, angle, color){
        this.numero = numero;
        this.angle = angle;
        this.color = color;
    }
}

const array_color = ["#579b66", "#f34a47", "#79b0cf", "#877cc7", "#d3396e","#ffc114", "#aea98c", "#ff983a"]
let array_triangles = [];

for(let i = 1; i < 9; i += 1){
    let a_s = 360;
    array_triangles.push(new Triangle( i - 1, a_s, array_color[i - 1]))
}


const mafonction = () => {
    randomslow = Math.random() * (0.03 - 0.012) + 0.012;
    stopper = true;
}
