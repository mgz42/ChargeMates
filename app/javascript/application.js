// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "@rails/actioncable"
import flatpickr from "flatpickr";


document.addEventListener("turbo:load", () => {
  flatpickr("#start_date", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
});
