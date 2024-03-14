import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="roue"
export default class extends Controller {

  static targets = ["boutonroue1", "boutonroue2","boutonroue3","boutonroue4","popuproue"];

  connect() {
    getcontext();
    init();
    document.getElementsByClassName("notification-red")[0].classList.add("d-none");
    if(!this.popuproueTarget.classList.contains("d-none")){
      this.popuproueTarget.classList.add("d-none");
      }
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

  disconnect(){
    console.log("goodbye")
  }
}

// CANVAS CODE

// Important variables
let lv1 = document.getElementById("lv1");
let xp2 = document.getElementById("2xp");
let cristal = document.getElementById("cristal");
let week_special = document.getElementById("sp_week");
let bonuse = document.getElementById("bonuse");
let freezem = document.getElementById("freezem");
let freeze = document.getElementById("freeze");
let none = document.getElementById("noneb");
let ctx = "";

let speed = 1;
let accelerate = true;
let stopper = false;
let randomslow = 0.02;
let start = false;

const getcontext = () => {
  ctx = document.querySelector("#laroue").getContext("2d");
}

const hash_of_badges = { "#579b66": "cristal", "#d3396e": "freeze_week", "#877cc7": "freeze_month", "#f34a47" : "minus_one_euro","#ffc114" : "level_up", "#aea98c" : "none", "#ff983a": "double_xp", "#79b0cf": "weekly_special" };
const hash_de_noms = {"double_xp": "Double XP 24 heures", "freeze_week" : "Gel de série deux semaine", "freeze_month" : "Gel de série un mois", "minus_one_euro" : "Moins un euro sur votre prochaine commande", "level_up": "Plus un niveau", "cristal" : "Cristal", "weekly_special" : "Badge de la semaine"};
const hash_image = {"#579b66": cristal, "#d3396e": freeze, "#877cc7": freezem, "#f34a47" : bonuse,"#ffc114" : lv1, "#ff983a": xp2, "#79b0cf": week_special}
const array_color = ["#579b66", "#f34a47", "#79b0cf", "#877cc7", "#d3396e","#ffc114", "#aea98c", "#ff983a"]
let array_triangles = [];

// fonction finale
const give_the_result = (color) => {

  let texte_popup = "Malheuresement, vous n'avez pas gagné de bonus aujourd'hui. Revenez demain !";

  if (hash_of_badges[color] !== "none"){
    texte_popup = "Félicitation, vous avec gagné un bonus:";
    document.getElementById("bonus-popup-roue").innerHTML = hash_de_noms[hash_of_badges[color]] + " !";
  }

  document.getElementById("texte-du-popup-roue").innerHTML = texte_popup;

  setTimeout(() => {
    document.getElementById("dark-behind").classList.toggle("d-none");
    setTimeout(() => {
      document.querySelector(".pop-up-roue").classList.add("scaled")
    }, 15);
  }, 500);

  let date = new Date();
  let thebody = new FormData();
  thebody.append("user[wheel]", date);

  fetch("/users/1", {
    method: "PATCH",
    headers: { "Accept": "application/json" }
  })

  let thebody2 = new FormData();
  thebody2.append("badge[name]", hash_of_badges[color])

  if (hash_of_badges[color] !== "none"){
  fetch("/badges", {
    method: "POST",
    headers: { "Accept": "application/json" },
    body: thebody2
  })
  }
}

// creer la roue statique
const init = () => {
    window.requestAnimationFrame(draw);
}

// animation
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

        let angle_end = triangle.angle + 45 > 360 ? triangle.angle + 45 - 360 : triangle.angle + 45;

        ctx.fillStyle = triangle.color;
        ctx.beginPath();
        ctx.moveTo(500, 500);
        ctx.arc(500,500,500, Math.PI*2*(triangle.angle/360) , Math.PI*2*(triangle.angle/360) + (Math.PI*2*0.125));
        ctx.lineTo(500,500);
        ctx.fill();

        ctx.fillStyle = "white";
        ctx.arc(500, 140, 5, 0, Math.PI * 2)
        let x = 450 + 350 * Math.cos(((triangle.angle*Math.PI/180) + (angle_end*Math.PI/180)) / 2 );
        let y = 450 + 350 * Math.sin(((triangle.angle*Math.PI/180) + (angle_end*Math.PI/180)) / 2 );

        if (triangle.color != "#aea98c"){
          ctx.drawImage(hash_image[triangle.color], x, y, 100, 100) ;
        } else {
          ctx.drawImage(none, x, y, 100, 100) ;
        }
    })

    ctx.beginPath();
    ctx.arc(500, 500, 80, 0, Math.PI * 2)
    ctx.fillStyle = "rgba(0,0,0,0.2)";
    ctx.fill();

    ctx.beginPath();
    ctx.arc(500, 500, 60, 0, Math.PI * 2)
    ctx.fillStyle = "#f5f4f0";
    ctx.fill();

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
                start = false;
            }
        })
    }
}

// class initialisation
class Triangle{
    constructor(numero, angle, color){
        this.numero = numero;
        this.angle = angle;
        this.color = color;
    }
}

//instances of class
for(let i = 1; i < 9; i += 1){
    let a_s = 360;
    array_triangles.push(new Triangle( i - 1, a_s, array_color[i - 1]))
}

const mafonction = () => {
    randomslow = Math.random() * (0.03 - 0.012) + 0.012;
    stopper = true;
}
