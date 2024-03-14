import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification-none"
export default class extends Controller {

  launch_pop() {
    console.log("le pop up se lance")
    document.getElementById("mon_xp").classList.remove("d-none");
    document.getElementById("mon_xp").style.opacity = 1;
    document.getElementById("mon_xp").style.top = "40%";

    setTimeout(() => {
      document.getElementById("mon_xp").style.opacity = 0;
      setTimeout(() => {
        document.getElementById("mon_xp").classList.add("d-none");
      }, 1000);
    }, 2000);
  }

  hide() {
    document.getElementById("notif-b").classList.add("d-none");
  }
}
